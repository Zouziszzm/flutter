import 'package:flutter_test/flutter_test.dart';
import 'package:lumen/core/html_text.dart';

void main() {
  test('classifies [sound:] as audio or video', () {
    final media = extractMedia(
      'Say [sound:word.mp3] then watch [sound:clip.mp4]',
    );
    expect(media.audio, ['word.mp3']);
    expect(media.video, ['clip.mp4']);
    expect(media.images, isEmpty);
  });

  test('picks up html audio and video src', () {
    final media = extractMedia(
      '<img src="pic.jpg"><audio src="a.m4a"></audio><video src="v.mov"></video>',
    );
    expect(media.images, ['pic.jpg']);
    expect(media.audio, ['a.m4a']);
    expect(media.video, ['v.mov']);
  });

  test('rewrites sound tags to local paths', () {
    final html = rewriteMediaSrc(
      'Play [sound:clip.mp3] <img src="pic.jpg">',
      {'clip.mp3': '/tmp/clip.mp3', 'pic.jpg': '/tmp/pic.jpg'},
    );
    expect(html.contains('[sound:/tmp/clip.mp3]'), isTrue);
    expect(html.contains('src="/tmp/pic.jpg"'), isTrue);
  });
}
