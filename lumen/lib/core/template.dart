import 'html_text.dart';

final _mustacheRe = RegExp(r'\{\{([^}]+)\}\}');
final _clozeRe = RegExp(r'\{\{c(\d+)::(.*?)(?:::(.*?))?\}\}', dotAll: true);

class RenderedCard {
  const RenderedCard({
    required this.front,
    required this.back,
    this.frontImages = const [],
    this.backImages = const [],
    this.frontAudio = const [],
    this.backAudio = const [],
    this.frontVideo = const [],
    this.backVideo = const [],
  });

  final String front;
  final String back;
  final List<String> frontImages;
  final List<String> backImages;
  final List<String> frontAudio;
  final List<String> backAudio;
  final List<String> frontVideo;
  final List<String> backVideo;

  List<String> get images => [...frontImages, ..._onlyIn(backImages, frontImages)];
  List<String> get audio => [...frontAudio, ..._onlyIn(backAudio, frontAudio)];
  List<String> get video => [...frontVideo, ..._onlyIn(backVideo, frontVideo)];

  RenderedCard resolved(List<String> Function(List<String>) resolve) {
    return RenderedCard(
      front: front,
      back: back,
      frontImages: resolve(frontImages),
      backImages: resolve(backImages),
      frontAudio: resolve(frontAudio),
      backAudio: resolve(backAudio),
      frontVideo: resolve(frontVideo),
      backVideo: resolve(backVideo),
    );
  }
}

List<String> _onlyIn(List<String> items, List<String> exclude) {
  return items.where((item) => !exclude.contains(item)).toList();
}

/// Independent Anki-like template renderer (mustache fields + cloze).
RenderedCard renderCard({
  required String frontTemplate,
  required String backTemplate,
  required Map<String, String> fields,
  required int cardOrd,
  required bool isCloze,
}) {
  final processed = <String, String>{};
  for (final e in fields.entries) {
    processed[e.key] = isCloze ? _applyCloze(e.value, cardOrd + 1) : e.value;
  }

  var front = _fill(frontTemplate, processed, frontSide: null);
  var back = _fill(backTemplate, processed, frontSide: front);

  if (front.trim().isEmpty && fields.isNotEmpty) {
    final values = fields.values.toList();
    front = isCloze ? _applyCloze(values.first, cardOrd + 1, side: _ClozeSide.front) : values.first;
    back = values.length > 1 ? values[1] : values.first;
    if (isCloze) {
      back = _applyCloze(values.first, cardOrd + 1, side: _ClozeSide.back);
    }
  }

  final frontMedia = extractMedia(front);
  final backMedia = extractMedia(back);
  return RenderedCard(
    front: stripHtml(front),
    back: stripHtml(back),
    frontImages: frontMedia.images,
    backImages: backMedia.images,
    frontAudio: frontMedia.audio,
    backAudio: backMedia.audio,
    frontVideo: frontMedia.video,
    backVideo: backMedia.video,
  );
}

enum _ClozeSide { front, back, both }

String _applyCloze(String text, int clozeN, {_ClozeSide side = _ClozeSide.both}) {
  return text.replaceAllMapped(_clozeRe, (m) {
    final n = int.parse(m.group(1)!);
    final answer = m.group(2) ?? '';
    final hint = m.group(3);
    if (n == clozeN) {
      if (side == _ClozeSide.back) return answer;
      if (side == _ClozeSide.front) {
        return hint != null && hint.isNotEmpty ? '[$hint]' : '[…]';
      }
      return '[…]';
    }
    return answer;
  });
}

String _fill(String template, Map<String, String> fields, {String? frontSide}) {
  var out = template;
  if (frontSide != null) {
    out = out.replaceAll('{{FrontSide}}', frontSide);
  }
  out = out.replaceAllMapped(_mustacheRe, (m) {
    final raw = m.group(1)!.trim();
    if (raw == 'FrontSide') return frontSide ?? '';
    if (raw.startsWith('cloze:')) {
      final name = raw.substring(6);
      return fields[name] ?? '';
    }
    if (raw.startsWith('text:')) {
      return stripHtml(fields[raw.substring(5)] ?? '');
    }
    if (raw.startsWith('#') || raw.startsWith('/') || raw.startsWith('^')) {
      return '';
    }
    if (raw.startsWith('type:')) {
      return fields[raw.substring(5)] ?? '';
    }
    return fields[raw] ?? '';
  });
  return out;
}

bool looksLikeCloze(Map<String, String> fields) {
  return fields.values.any(_clozeRe.hasMatch);
}
