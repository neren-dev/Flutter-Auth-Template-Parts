import 'package:auth_ano_g_e/gen/assets.gen.dart';
import 'package:auth_ano_g_e/gen/fonts.gen.dart';
import 'package:auth_ano_g_e/features/shared/services/platform_checker.dart';
import 'package:auth_ano_g_e/core/widgets/press_scale_wrapper.dart';
import 'package:auth_ano_g_e/core/widgets/theme_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// add required assets (G icon svg & Roboto font) then remove fallback icon line 93 uncomment child of SizedBox (line 94-102) & the fontFamily prameter of TextStyle in text (line 114)
// text scale has been disabled for the text of button (line 116)

/// If the icon svg you are using has no extra padding and has only the G icon, then use sized box of size of 20x20, and as its child use svg with BoxFit.scaleDown
///
/// If the icon svg you are using is actually 20x20 & if its viewBox is also 20x20, then simply use sized box of 20x20 and put svg as its child & don't modify fit parameter.
///
/// Incase the viewBox is more than 20x20,
/// then you can use BoxFit.none then align icon then clip it to 20x20 then add on top sized box of 20x20.
///
/// Prefer using scale change of complete button incase of using text scaling
///
class GoogleCtnBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;
  final bool isActive;

  const GoogleCtnBtn({
    super.key,
    required this.onPressed,
    required this.enabled,
    required this.isActive,
  });

  static const _opacityChangeDuration = Duration(milliseconds: 350);

  @override
  Widget build(BuildContext context) {
    final isLarge = currentPlatform == AppPlatform.ios;
    final theme = AuthThemeHelpers.isDark(context)
        ? GoogleButtonTheme.dark
        : GoogleButtonTheme.light;

    final progressIndicatorColor = theme == GoogleButtonTheme.dark
        ? Colors.white
        : Colors.black;

    final height = isLarge ? 44.0 : 40.0;
    final horizontalPadding = isLarge ? 16.0 : 12.0;
    final gap = isLarge ? 12.0 : 10.0;

    final colors = _resolveColors(theme);

    final btn = PressScaleWrapper(
      enabled: enabled,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            opacity: isActive
                ? 0.6
                : enabled
                ? 1
                : 0.75,
            duration: _opacityChangeDuration,
            child: ElevatedButton(
              onPressed: enabled ? onPressed : null,

              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size.fromHeight(height)),
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                backgroundColor: WidgetStatePropertyAll(colors.fill),
                surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(height / 2),
                      right: Radius.circular(height / 2),
                    ),
                    side: BorderSide(
                      color: colors.stroke,
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: 1,
                    ),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Google Icon (fixed size)
                    SizedBox.fromSize(
                      size: const Size.square(20),
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            Assets.icons.googleAuth.googleGSvg,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: gap),

                    Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: 14,
                        height: 20 / 14,
                        fontWeight: FontWeight.w500,
                        color: colors.text,
                        fontFamily: FontFamily.roboto,
                      ),
                      textScaler: TextScaler.linear(1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isActive)
            AnimatedOpacity(
              duration: _opacityChangeDuration,
              opacity: isActive ? 1 : 0,
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: progressIndicatorColor,
                  // color: AuthColors.blue.withBlue(255),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
        ],
      ),
    );

    return btn;
  }

  _GoogleButtonColors _resolveColors(GoogleButtonTheme theme) {
    switch (theme) {
      case GoogleButtonTheme.dark:
        return _GoogleButtonColors(
          fill: const Color(0xFF131314),
          stroke: const Color(0xFF8E918F),
          text: const Color(0xFFE3E3E3),
        );

      case GoogleButtonTheme.neutral:
        return _GoogleButtonColors(
          fill: const Color(0xFFF2F2F2),
          stroke: Colors.transparent,
          text: const Color(0xFF1F1F1F),
        );

      case GoogleButtonTheme.light:
        return _GoogleButtonColors(
          fill: const Color(0xFFFFFFFF),
          stroke: const Color(0xFF747775),
          text: const Color(0xFF1F1F1F),
        );
    }
  }
}

class _GoogleButtonColors {
  final Color fill;
  final Color stroke;
  final Color text;

  _GoogleButtonColors({
    required this.fill,
    required this.stroke,
    required this.text,
  });
}

enum GoogleButtonTheme { light, dark, neutral }
