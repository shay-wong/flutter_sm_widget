import 'package:flutter/material.dart';
import 'package:flutter_sm_widget/sm_widget.dart';

class MCircleAvatar extends StatelessWidget {
  const MCircleAvatar({
    super.key,
    this.source,
    this.child,
    this.backgroundColor,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.foregroundColor,
    double? radius,
    this.minRadius,
    this.maxRadius,
    this.placeholder,
    this.onTap,
    this.package,
    this.bundle,
    double? diameter,
    this.fit,
  })  : assert(radius == null || diameter == null || (minRadius == null && maxRadius == null)),
        assert(source != null || backgroundImage != null || onBackgroundImageError == null),
        assert(foregroundImage != null || onForegroundImageError == null),
        diameter = diameter ?? (radius != null ? radius * 2.0 : null);

  final Color? backgroundColor;
  final ImageProvider? backgroundImage;
  final AssetBundle? bundle;
  final Widget? child;
  final Color? foregroundColor;
  final ImageProvider? foregroundImage;
  final double? maxRadius;
  final double? minRadius;
  final ImageErrorListener? onBackgroundImageError;
  final ImageErrorListener? onForegroundImageError;
  final VoidCallback? onTap;
  final String? package;
  final String? placeholder;
  final double? diameter;
  final String? source;
  final BoxFit? fit;

  // The default max if only the min is specified.
  static const double _defaultMaxRadius = double.infinity;

  // The default min if only the max is specified.
  static const double _defaultMinRadius = 0.0;

  // The default radius if nothing is specified.
  static const double _defaultRadius = 20.0;

  double get _maxDiameter {
    if (diameter == null && minRadius == null && maxRadius == null) {
      return _defaultRadius * 2.0;
    }
    return diameter ?? 2.0 * (maxRadius ?? _defaultMaxRadius);
  }

  double get _minDiameter {
    if (diameter == null && minRadius == null && maxRadius == null) {
      return _defaultRadius * 2.0;
    }
    return diameter ?? 2.0 * (minRadius ?? _defaultMinRadius);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final ThemeData theme = Theme.of(context);
    final Color? effectiveForegroundColor =
        foregroundColor ?? (theme.useMaterial3 ? theme.colorScheme.onPrimaryContainer : null);
    final TextStyle effectiveTextStyle =
        theme.useMaterial3 ? theme.textTheme.titleMedium! : theme.primaryTextTheme.titleMedium!;
    TextStyle textStyle = effectiveTextStyle.copyWith(color: effectiveForegroundColor);
    Color? effectiveBackgroundColor =
        backgroundColor ?? (theme.useMaterial3 ? theme.colorScheme.primaryContainer : null);
    if (effectiveBackgroundColor == null) {
      switch (ThemeData.estimateBrightnessForColor(textStyle.color!)) {
        case Brightness.dark:
          effectiveBackgroundColor = theme.primaryColorLight;
        case Brightness.light:
          effectiveBackgroundColor = theme.primaryColorDark;
      }
    } else if (effectiveForegroundColor == null) {
      switch (ThemeData.estimateBrightnessForColor(backgroundColor!)) {
        case Brightness.dark:
          textStyle = textStyle.copyWith(color: theme.primaryColorLight);
        case Brightness.light:
          textStyle = textStyle.copyWith(color: theme.primaryColorDark);
      }
    }
    final double minDiameter = _minDiameter;
    final double maxDiameter = _maxDiameter;
    Widget widget = AnimatedContainer(
      constraints: BoxConstraints(
        minHeight: minDiameter,
        minWidth: minDiameter,
        maxWidth: maxDiameter,
        maxHeight: maxDiameter,
      ),
      duration: kThemeChangeDuration,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        image: _effectiveBackgroundImage,
        shape: BoxShape.circle,
      ),
      foregroundDecoration: foregroundImage != null
          ? BoxDecoration(
              image: DecorationImage(
                image: foregroundImage!,
                onError: onForegroundImageError,
                fit: fit ?? BoxFit.cover,
              ),
              shape: BoxShape.circle,
            )
          : null,
      child: child == null
          ? null
          : Center(
              // Need to disable text scaling here so that the text doesn't
              // escape the avatar when the textScaleFactor is large.
              child: MediaQuery.withNoTextScaling(
                child: IconTheme(
                  data: theme.iconTheme.copyWith(color: textStyle.color),
                  child: DefaultTextStyle(
                    style: textStyle,
                    child: child!,
                  ),
                ),
              ),
            ),
    );

    if (onTap != null) {
      widget = InkWell(
        onTap: onTap,
        child: widget,
      );
    }
    return widget;
  }

  DecorationImage? get _effectiveBackgroundImage {
    if (backgroundImage != null) {
      return DecorationImage(
        image: backgroundImage!,
        onError: onBackgroundImageError,
        fit: fit ?? BoxFit.cover,
      );
    }
    if (source != null) {
      return DecorationImage(
        image: MImage.provider(
          source,
          placeholderImage: MImage.provider(
            placeholder ?? 'assets/images/icons/avatar.png',
            package: placeholder == null ? 'flutter_sm_widget' : package,
          ),
          package: package,
          bundle: bundle,
        ),
        onError: onBackgroundImageError,
        fit: fit ?? BoxFit.cover,
      );
    }
    return null;
  }
}
