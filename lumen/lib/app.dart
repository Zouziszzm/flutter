import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/shell/app_shell.dart';
import 'providers.dart';
import 'theme/lumen_theme.dart';

class LumenApp extends ConsumerWidget {
  const LumenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'Lumen',
      debugShowCheckedModeBanner: false,
      theme: LumenTheme.light(),
      darkTheme: LumenTheme.dark(),
      themeMode: mode,
      builder: (context, child) {
        final brightness = Theme.of(context).brightness;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: brightness == Brightness.dark
              ? SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: LumenColors.darkBg,
                )
              : SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: LumenColors.lightBg,
                ),
          child: DefaultTextStyle.merge(
            style: const TextStyle(
              decoration: TextDecoration.none,
              decorationColor: Color(0x00000000),
              decorationThickness: 0,
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      home: const AppShell(),
    );
  }
}
