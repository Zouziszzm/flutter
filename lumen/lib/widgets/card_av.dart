import 'dart:async';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

import '../theme/lumen_theme.dart';

/// Images, autoplaying audio, and inline video for one card side.
class CardAv extends StatelessWidget {
  const CardAv({
    super.key,
    required this.images,
    required this.audio,
    required this.video,
    this.autoplay = true,
  });

  final List<String> images;
  final List<String> audio;
  final List<String> video;
  final bool autoplay;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty && audio.isEmpty && video.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          if (video.isNotEmpty)
            _Videos(paths: video.where(_exists).toList(), autoplay: autoplay),
          if (images.isNotEmpty) ...[
            if (video.isNotEmpty) const SizedBox(height: 12),
            _Images(paths: images.where(_exists).toList()),
          ],
          if (audio.isNotEmpty) ...[
            const SizedBox(height: 12),
            _AudioBar(paths: audio.where(_exists).toList(), autoplay: autoplay),
          ],
        ],
      ),
    );
  }
}

bool _exists(String path) => File(path).existsSync();

class _Images extends StatelessWidget {
  const _Images({required this.paths});

  final List<String> paths;

  @override
  Widget build(BuildContext context) {
    if (paths.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        for (final path in paths)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(path),
              height: 180,
              fit: BoxFit.contain,
            ),
          ),
      ],
    );
  }
}

class _AudioBar extends StatefulWidget {
  const _AudioBar({required this.paths, required this.autoplay});

  final List<String> paths;
  final bool autoplay;

  @override
  State<_AudioBar> createState() => _AudioBarState();
}

class _AudioBarState extends State<_AudioBar> {
  final _player = AudioPlayer();
  StreamSubscription<PlayerState>? _sub;
  var _index = 0;
  var _playing = false;

  @override
  void initState() {
    super.initState();
    _sub = _player.playerStateStream.listen((state) {
      if (!mounted) return;
      setState(() => _playing = state.playing);
      if (state.processingState == ProcessingState.completed) {
        _playNext();
      }
    });
    if (widget.autoplay) {
      _start();
    }
  }

  Future<void> _start() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(AudioSessionConfiguration.speech());
    } catch (_) {}
    _index = 0;
    await _playAt(_index);
  }

  Future<void> _playNext() async {
    if (_index + 1 >= widget.paths.length) {
      _index = 0;
      return;
    }
    _index += 1;
    await _playAt(_index);
  }

  Future<void> _playAt(int i) async {
    if (i < 0 || i >= widget.paths.length) return;
    try {
      await _player.setFilePath(widget.paths[i]);
      await _player.play();
    } catch (_) {}
  }

  Future<void> _toggle() async {
    if (_player.playing) {
      await _player.pause();
      return;
    }
    if (_player.processingState == ProcessingState.idle ||
        _player.processingState == ProcessingState.completed) {
      await _start();
      return;
    }
    await _player.play();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    final label = widget.paths.length > 1
        ? 'Audio ${_index + 1}/${widget.paths.length}'
        : 'Audio';
    return GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: t.elevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: t.border),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _playing ? Icons.pause_rounded : Icons.volume_up_rounded,
                size: 20,
                color: t.accent,
              ),
              const SizedBox(width: 8),
              Text(
                _playing ? 'Playing' : 'Play $label',
                style: TextStyle(
                  color: t.accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Videos extends StatelessWidget {
  const _Videos({required this.paths, required this.autoplay});

  final List<String> paths;
  final bool autoplay;

  @override
  Widget build(BuildContext context) {
    if (paths.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        for (var i = 0; i < paths.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          _VideoClip(path: paths[i], autoplay: autoplay && i == 0),
        ],
      ],
    );
  }
}

class _VideoClip extends StatefulWidget {
  const _VideoClip({required this.path, required this.autoplay});

  final String path;
  final bool autoplay;

  @override
  State<_VideoClip> createState() => _VideoClipState();
}

class _VideoClipState extends State<_VideoClip> {
  VideoPlayerController? _controller;
  var _ready = false;
  var _failed = false;

  @override
  void initState() {
    super.initState();
    final controller = VideoPlayerController.file(File(widget.path));
    _controller = controller;
    controller.initialize().then((_) async {
      if (!mounted) return;
      await controller.setLooping(false);
      setState(() => _ready = true);
      if (widget.autoplay) {
        await controller.play();
      }
    }).catchError((_) {
      if (mounted) setState(() => _failed = true);
    });
    controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = LumenTokens.of(context);
    if (_failed) {
      return Text('Could not play video', style: TextStyle(color: t.muted, fontSize: 13));
    }
    final controller = _controller;
    if (!_ready || controller == null || !controller.value.isInitialized) {
      return const SizedBox(height: 160);
    }
    final size = controller.value.size;
    final playing = controller.value.isPlaying;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 240),
        child: AspectRatio(
          aspectRatio: size.width == 0 || size.height == 0
              ? 16 / 9
              : size.width / size.height,
          child: GestureDetector(
            onTap: () {
              if (playing) {
                controller.pause();
              } else {
                controller.play();
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(controller),
                if (!playing)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0x880E0E0C),
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
