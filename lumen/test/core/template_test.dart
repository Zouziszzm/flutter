import 'package:flutter_test/flutter_test.dart';
import 'package:lumen/core/template.dart';

void main() {
  test('renders basic front and back', () {
    final card = renderCard(
      frontTemplate: '{{Front}}',
      backTemplate: '{{FrontSide}}<hr id=answer>{{Back}}',
      fields: {'Front': 'Capital of France?', 'Back': 'Paris'},
      cardOrd: 0,
      isCloze: false,
    );
    expect(card.front, 'Capital of France?');
    expect(card.back.contains('Paris'), isTrue);
  });

  test('renders cloze on the matching card', () {
    final card = renderCard(
      frontTemplate: '{{cloze:Text}}',
      backTemplate: '{{cloze:Text}}',
      fields: {'Text': 'The {{c1::Seine}} runs through Paris'},
      cardOrd: 0,
      isCloze: true,
    );
    expect(card.front.contains('Seine'), isFalse);
    expect(card.front.contains('[…]'), isTrue);
  });

  test('splits [sound:] into audio vs video per side', () {
    final card = renderCard(
      frontTemplate: '{{Front}}',
      backTemplate: '{{Back}}',
      fields: {
        'Front': 'Listen [sound:clip.mp3]',
        'Back': 'Watch [sound:clip.mp4]',
      },
      cardOrd: 0,
      isCloze: false,
    );
    expect(card.front, 'Listen');
    expect(card.back, 'Watch');
    expect(card.frontAudio, ['clip.mp3']);
    expect(card.backVideo, ['clip.mp4']);
    expect(card.frontVideo, isEmpty);
    expect(card.backAudio, isEmpty);
  });
}
