final _tagRe = RegExp(r'<[^>]+>');
final _brRe = RegExp(r'<br\s*/?>', caseSensitive: false);
final _hrRe = RegExp(r'<hr[^>]*>', caseSensitive: false);
final _divPRe = RegExp(r'</(p|div)>', caseSensitive: false);
final _imgRe = RegExp(r'''<img[^>]+src=["']([^"']+)["']''', caseSensitive: false);
final _videoSrcRe = RegExp(
  r'''<(?:video|source)[^>]+src=["']([^"']+)["']''',
  caseSensitive: false,
);
final _audioSrcRe = RegExp(r'''<audio[^>]+src=["']([^"']+)["']''', caseSensitive: false);
final _soundRe = RegExp(r'\[sound:([^\]]+)\]');
final _entityRe = RegExp(r'&(#\d+|#x[0-9a-fA-F]+|\w+);');

const _videoExt = {'mp4', 'webm', 'mov', 'mkv', 'm4v', 'avi', 'ogv'};

class CardMedia {
  const CardMedia({
    required this.images,
    required this.audio,
    required this.video,
  });

  final List<String> images;
  final List<String> audio;
  final List<String> video;
}

bool isVideoFile(String name) => _videoExt.contains(_ext(name));

String _ext(String name) {
  final base = name.split('?').first.split('#').first;
  final slash = base.lastIndexOf('/');
  final file = slash >= 0 ? base.substring(slash + 1) : base;
  final dot = file.lastIndexOf('.');
  if (dot < 0 || dot == file.length - 1) return '';
  return file.substring(dot + 1).toLowerCase();
}

void _addUnique(List<String> into, String name) {
  if (!into.contains(name)) into.add(name);
}

CardMedia extractMedia(String html) {
  final images = _imgRe.allMatches(html).map((m) => m.group(1)!).toList();
  final audio = <String>[];
  final video = <String>[];

  void addSound(String name) {
    if (isVideoFile(name)) {
      _addUnique(video, name);
    } else {
      _addUnique(audio, name);
    }
  }

  for (final m in _soundRe.allMatches(html)) {
    addSound(m.group(1)!);
  }
  for (final m in _videoSrcRe.allMatches(html)) {
    addSound(m.group(1)!);
  }
  for (final m in _audioSrcRe.allMatches(html)) {
    addSound(m.group(1)!);
  }

  return CardMedia(images: images, audio: audio, video: video);
}

String stripHtml(String html) {
  var text = html.replaceAll(_brRe, '\n');
  text = text.replaceAll(_hrRe, '\n');
  text = text.replaceAll(_divPRe, '\n');
  text = text.replaceAll(_soundRe, '');
  text = text.replaceAll(_tagRe, '');
  text = text.replaceAllMapped(_entityRe, (m) {
    final e = m.group(1)!;
    return switch (e) {
      'nbsp' => ' ',
      'amp' => '&',
      'lt' => '<',
      'gt' => '>',
      'quot' => '"',
      'apos' => "'",
      _ => m.group(0)!,
    };
  });
  return text
      .split('\n')
      .map((l) => l.trim())
      .where((l) => l.isNotEmpty)
      .join('\n');
}

String rewriteMediaSrc(String html, Map<String, String> filenameToPath) {
  var out = html;
  for (final entry in filenameToPath.entries) {
    out = out.replaceAll('src="${entry.key}"', 'src="${entry.value}"');
    out = out.replaceAll("src='${entry.key}'", "src='${entry.value}'");
    out = out.replaceAll('[sound:${entry.key}]', '[sound:${entry.value}]');
  }
  return out;
}
