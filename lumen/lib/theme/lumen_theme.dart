import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Warm, quiet palette. No motion — premium is spacing, type, and restraint.
class LumenColors {
  const LumenColors._();

  static const darkBg = Color(0xFF0E0E0C);
  static const darkSurface = Color(0xFF161613);
  static const darkElevated = Color(0xFF1C1C18);
  static const darkBorder = Color(0xFF2A2A24);
  static const darkText = Color(0xFFF2EDE4);
  static const darkMuted = Color(0xFF9A9488);
  static const darkFaint = Color(0xFF6A655C);

  static const lightBg = Color(0xFFF6F3EC);
  static const lightSurface = Color(0xFFFFFCF7);
  static const lightElevated = Color(0xFFFFFFFF);
  static const lightBorder = Color(0xFFE4DDD0);
  static const lightText = Color(0xFF1A1916);
  static const lightMuted = Color(0xFF6F6A60);
  static const lightFaint = Color(0xFF9A9488);

  static const gold = Color(0xFFC4A574);
  static const goldDeep = Color(0xFF8B6914);

  static const again = Color(0xFFC45C4A);
  static const hard = Color(0xFFC4924A);
  static const good = Color(0xFF6B9B6E);
  static const easy = Color(0xFF5B7FA5);
}

class LumenTheme {
  const LumenTheme._();

  static const _serifFamily = <String>['New York', 'Georgia', 'Times New Roman'];

  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        bg: LumenColors.darkBg,
        surface: LumenColors.darkSurface,
        elevated: LumenColors.darkElevated,
        border: LumenColors.darkBorder,
        text: LumenColors.darkText,
        muted: LumenColors.darkMuted,
        faint: LumenColors.darkFaint,
        accent: LumenColors.gold,
      );

  static ThemeData light() => _build(
        brightness: Brightness.light,
        bg: LumenColors.lightBg,
        surface: LumenColors.lightSurface,
        elevated: LumenColors.lightElevated,
        border: LumenColors.lightBorder,
        text: LumenColors.lightText,
        muted: LumenColors.lightMuted,
        faint: LumenColors.lightFaint,
        accent: LumenColors.goldDeep,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color bg,
    required Color surface,
    required Color elevated,
    required Color border,
    required Color text,
    required Color muted,
    required Color faint,
    required Color accent,
  }) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: accent.withValues(alpha: 0.06),
      focusColor: accent.withValues(alpha: 0.10),
      scaffoldBackgroundColor: bg,
      canvasColor: surface,
      dividerColor: border,
    );

    final textTheme = base.textTheme.apply(
      bodyColor: text,
      displayColor: text,
      decoration: TextDecoration.none,
    );

    return base.copyWith(
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: accent,
        onPrimary: bg,
        secondary: muted,
        onSecondary: bg,
        error: LumenColors.again,
        onError: Colors.white,
        surface: surface,
        onSurface: text,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        foregroundColor: text,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: text,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
          decoration: TextDecoration.none,
        ),
      ),
      dividerTheme: DividerThemeData(color: border, space: 1, thickness: 1),
      dialogTheme: DialogThemeData(
        backgroundColor: elevated,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: elevated,
        hintStyle: TextStyle(color: faint),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: border, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          for (final platform in TargetPlatform.values)
            platform: const _InstantPageTransitionsBuilder(),
        },
      ),
      extensions: <ThemeExtension<dynamic>>[
        LumenTokens(
          bg: bg,
          surface: surface,
          elevated: elevated,
          border: border,
          text: text,
          muted: muted,
          faint: faint,
          accent: accent,
          serifFamily: _serifFamily,
        ),
      ],
    );
  }
}

class LumenTokens extends ThemeExtension<LumenTokens> {
  const LumenTokens({
    required this.bg,
    required this.surface,
    required this.elevated,
    required this.border,
    required this.text,
    required this.muted,
    required this.faint,
    required this.accent,
    required this.serifFamily,
  });

  final Color bg;
  final Color surface;
  final Color elevated;
  final Color border;
  final Color text;
  final Color muted;
  final Color faint;
  final Color accent;
  final List<String> serifFamily;

  static LumenTokens of(BuildContext context) {
    return Theme.of(context).extension<LumenTokens>()!;
  }

  static bool phone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 700;

  @override
  LumenTokens copyWith({
    Color? bg,
    Color? surface,
    Color? elevated,
    Color? border,
    Color? text,
    Color? muted,
    Color? faint,
    Color? accent,
    List<String>? serifFamily,
  }) {
    return LumenTokens(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      elevated: elevated ?? this.elevated,
      border: border ?? this.border,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      faint: faint ?? this.faint,
      accent: accent ?? this.accent,
      serifFamily: serifFamily ?? this.serifFamily,
    );
  }

  @override
  LumenTokens lerp(ThemeExtension<LumenTokens>? other, double t) {
    if (other is! LumenTokens) return this;
    return t < 0.5 ? this : other;
  }
}

class _InstantPageTransitionsBuilder extends PageTransitionsBuilder {
  const _InstantPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
