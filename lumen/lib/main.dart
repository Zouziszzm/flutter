import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isMacOS) {
    await windowManager.ensureInitialized();
    const options = WindowOptions(
      size: Size(1280, 840),
      minimumSize: Size(880, 600),
      title: 'Lumen',
      titleBarStyle: TitleBarStyle.hidden,
      backgroundColor: Color(0xFF0E0E0C),
    );
    await windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const ProviderScope(child: LumenApp()));
}
