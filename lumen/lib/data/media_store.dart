import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class MediaStore {
  MediaStore({Directory? root}) : _root = root;

  Directory? _root;

  Future<Directory> root() async {
    if (_root != null) return _root!;
    final support = await getApplicationSupportDirectory();
    final dir = Directory(p.join(support.path, 'media'));
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    _root = dir;
    return dir;
  }

  Future<String> saveBytes(String filename, List<int> bytes) async {
    final dir = await root();
    final safe = p.basename(filename);
    final dest = File(p.join(dir.path, safe));
    await dest.writeAsBytes(bytes, flush: true);
    return dest.path;
  }

  Future<String> saveFile(String filename, File source) async {
    final bytes = await source.readAsBytes();
    return saveBytes(filename, bytes);
  }

  Future<String?> pathFor(String filename) async {
    final dir = await root();
    final file = File(p.join(dir.path, p.basename(filename)));
    return file.existsSync() ? file.path : null;
  }
}
