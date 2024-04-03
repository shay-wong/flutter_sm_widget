import 'package:flutter/material.dart';
import 'package:sm_widget/sm_widget.dart';

enum MInputBorderStyle {
  underline,
  outline,
}

class MInputDecoration extends InputDecoration {
  const MInputDecoration({
    super.icon,
    super.iconColor,
    super.label,
    super.labelText,
    super.labelStyle,
    super.floatingLabelStyle,
    super.helperText,
    super.helperStyle,
    super.helperMaxLines,
    super.hintText,
    super.hintStyle,
    super.hintTextDirection,
    super.hintMaxLines,
    super.hintFadeDuration,
    super.error,
    super.errorText,
    super.errorStyle,
    super.errorMaxLines,
    super.floatingLabelBehavior,
    super.floatingLabelAlignment,
    super.isCollapsed,
    super.isDense,
    super.contentPadding,
    super.prefixIcon,
    super.prefixIconConstraints,
    super.prefix,
    super.prefixText,
    super.prefixStyle,
    super.prefixIconColor,
    super.suffixIcon,
    super.suffix,
    super.suffixText,
    super.suffixStyle,
    super.suffixIconColor,
    super.suffixIconConstraints,
    super.counter,
    super.counterText,
    super.counterStyle,
    super.filled,
    super.fillColor,
    super.focusColor,
    super.hoverColor,
    super.errorBorder,
    super.focusedBorder,
    super.focusedErrorBorder,
    super.disabledBorder,
    super.enabledBorder,
    super.border,
    super.enabled = true,
    super.semanticCounterText,
    super.alignLabelWithHint,
    super.constraints,
    this.borderRadius,
    this.borderStyle = MInputBorderStyle.underline,
    this.gapPadding,
    this.height,
    this.hintColor,
    this.radius,
    this.side,
    this.suffixPadding,
    this.suffixIconPadding,
    this.text,
    this.width,
    this.uniformBorderStyles = false,
  });

  const MInputDecoration.collapsed({
    required super.hintText,
    super.floatingLabelBehavior,
    super.floatingLabelAlignment,
    super.hintStyle,
    super.hintTextDirection,
    super.filled = false,
    super.fillColor,
    super.focusColor,
    super.hoverColor,
    super.border = InputBorder.none,
    super.enabled = true,
  })  : borderRadius = null,
        borderStyle = MInputBorderStyle.underline,
        gapPadding = null,
        height = null,
        hintColor = null,
        radius = null,
        side = null,
        suffixPadding = null,
        suffixIconPadding = null,
        text = null,
        width = null,
        uniformBorderStyles = false;

  /// 如果 [labelText] 或者 [helperText] 存在，则将此标签与它们对齐
  // final bool? alignLabelWithHint;

  /// 输入框的边框, 默认情况下为 [UnderlineInputBorder].
  /// 如果设置了[borderRadius] 或 [radius] 或 [side] 或 [gapPadding], 则根据 [borderStyle] 重新计算边框
  /// 当你使用从 [InputBorder] 派生的边框时（比如 [UnderlineInputBorder] 或 [OutlineInputBorder]），
  /// Flutter 会自动调整边框的 [InputBorder.borderSide] 属性，
  /// 也就是说，它会根据输入框的状态（比如是否有错误、是否获得焦点等）来调整边框的颜色和宽度。
  /// 这意味着，即使你为 [border] 属性指定了颜色和宽度，这些设置也会被覆盖，以反映输入装饰器的当前状态。
  /// 因此，如果你想要为不同的输入状态（错误、聚焦、启用、禁用）保持自定义的边框样式，
  /// 你需要单独设置 [errorBorder]、[focusedBorder]、[enabledBorder] 和 [disabledBorder] 属性，而不是仅依赖于 border 属性。
  // final InputBorder? border;

  /// 边框圆角, 会统一设置所有状态下的 [border], 无视 [uniformBorderStyles]
  /// 但是优先级比单独设置某一状态的 [border] 低
  final BorderRadius? borderRadius;

  /// [border] 样式, 默认 [MInputBorderStyle.underline]
  final MInputBorderStyle borderStyle;

  /// 输入框的大小约束
  // final BoxConstraints? constraints;

  /// 内容的内边距
  /// 默认情况下，[contentPadding] 反映 [isDense] 和 [border] 的类型。
  /// 如果 [isCollapsed] 为true，那么 [contentPadding] 就是 [EdgeInsets.zero]。
  /// 如果 [border] 的 `isOutline` 属性为假，且 [filled] 为真，
  /// 则当 [isDense] 为真时，[contentPadding] 为 `EdgeInsets.fromLTRB(12, 8, 12, 8)`；
  /// 当 [isDense] 为假时，[contentPadding] 为 `EdgeInsets.fromLTRB(12, 12, 12, 12)`。
  /// 如果 [border] 的 `isOutline` 属性为 false，且 [filled] 为 false，
  /// 则当 [isDense] 为真时，[contentPadding] 为 `EdgeInsets.fromLTRB(0, 8, 0, 8)`；
  /// 当 [isDense] 为假时，[contentPadding] 为 `EdgeInsets.fromLTRB(0, 12, 0, 12)`。
  /// 如果 [border] 的 `isOutline` 属性为 true，
  /// 则当 [isDense] 为 true 时，[contentPadding] 为 `EdgeInsets.fromLTRB(12, 20, 12, 12)`；
  /// 当 [isDense] 为 false 时，[contentPadding] 为 `EdgeInsets.fromLTRB(12, 24, 12, 16)`。
  /// 如果设置了 [suffix] 相关属性，则此属性的 [EdgeInsetsGeometry.right] 将被忽略
  // final EdgeInsetsGeometry? contentPadding;

  /// 计数器
  // final  counter;

  /// 计数器的样式
  // final TextStyle? counterStyle;

  /// 计数器的文本
  // final String? counterText;

  /// 禁用状态下的边框
  // final InputBorder? disabledBorder;

  /// 是否启用输入框
  // final bool? enabled;

  /// 启用状态下的边框
  // final InputBorder? enabledBorder;

  /// 错误提示
  // final  error;

  /// 错误状态下的边框
  // final InputBorder? errorBorder;

  /// 错误提示的最大行数
  // final int? errorMaxLines;

  /// 错误提示的样式
  // final TextStyle? errorStyle;

  /// 错误提示的文本
  // final String? errorText;

  /// 输入框填充的颜色
  // final Color? fillColor;

  /// 是否填充输入框
  /// 如果为 "true"，装饰的容器将被填充为 [fillColor]。
  /// 默认为 "false", 当 [fillColor] 不为 null 时默认为 "true".
  // final bool? filled;

  /// 标签的对齐方式
  // final FloatingLabelAlignment? floatingLabelAlignment;

  /// 标签的行为
  // final FloatingLabelBehavior? floatingLabelBehavior;

  /// 标签的样式
  // final TextStyle? floatingLabelStyle;

  /// 输入框获取焦点时的颜色
  // final Color? focusColor;

  /// 获取焦点时的边框
  // final InputBorder? focusedBorder;

  /// 获取焦点时的错误边框
  // final InputBorder? focusedErrorBorder;

  /// 边框两侧的水平填充, 默认值为 4.0
  /// [InputDecoration.labelText] 宽度间隙.
  ///
  /// 此值由[paint]方法用于计算实际间隙宽度.
  final double? gapPadding;

  /// 限定高度, 会限定 [MTextField] 高度为 [height],
  /// 如果想设置初始高度, 在 [maxLines] > 1, 并且希望 [MTextField] 自适应高度的情况下,
  /// 推荐设置 [isDense] 为 true, 配合 [contentPadding] 来控制初始高度,
  /// 注意, [suffixIcon] 默认约束是 48x48, 如果要设置小于 48 的高度, 需要设置 [suffixIconConstraints.minHeight] 小于 48.
  final double? height;

  /// 是否折叠
  // final bool? isCollapsed;

  /// 是否紧凑
  // final bool? isDense;

  /// 标签
  // final  label;

  /// 标签的样式
  // final TextStyle? labelStyle;

  /// 标签的文本
  // final String? labelText;

  /// 提示颜色
  final Color? hintColor;

  /// 帮助提示的最大行数
  // final int? helperMaxLines;

  /// 帮助提示的样式
  // final TextStyle? helperStyle;

  /// 帮助提示的文本
  // final String? helperText;

  /// 提示文字淡出动画的持续时间
  // final Duration? hintFadeDuration;

  /// 提示文字的最大行数
  // final int? hintMaxLines;

  /// 提示文字的样式
  // final TextStyle? hintStyle;

  /// 提示文字的文本
  // final String? hintText;

  /// 提示文字的方向
  // final TextDirection? hintTextDirection;

  /// 鼠标悬浮时的颜色
  // final Color? hoverColor;

  /// 前缀图标
  // final  icon;

  /// 前缀图标的颜色
  // final Color? iconColor;

  /// 前缀
  // final  prefix;

  /// 前缀图标
  // final  prefixIcon;

  /// 前缀图标的颜色
  // final Color? prefixIconColor;

  /// 前缀图标的约束
  // final BoxConstraints? prefixIconConstraints;

  /// 前缀的样式
  // final TextStyle? prefixStyle;

  /// 前缀的文本
  // final String? prefixText;

  /// 圆角半径, 会统一设置所有状态下的 [border], 无视 [uniformBorderStyles]
  /// 但是优先级比单独设置某一状态的 [border] 低
  final double? radius;

  /// 统计信息的文本，用于读屏软件
  // final String? semanticCounterText;

  /// 边框颜色粗细等样式, 会统一设置所有状态下的 [border], 无视 [uniformBorderStyles]
  /// 但是优先级比单独设置某一状态的 [border] 低
  final BorderSide? side;

  /// 后缀图标的边距
  final EdgeInsetsGeometry? suffixIconPadding;

  /// 后缀
  // final  suffix;

  /// 后缀图标
  // final  suffixIcon;

  /// 后缀图标的颜色
  // final Color? suffixIconColor;

  /// 后缀图标的约束, 比如限制宽高, 默认是 48x48, 在 [InputDecorator] 中被设置为 [kMinInteractiveDimension]
  // final BoxConstraints? suffixIconConstraints;

  /// 后缀的样式
  // final TextStyle? suffixStyle;

  /// 后缀的文本, 如果和 [suffixIcon] 一起使用，会显示在图标的前面
  // final String? suffixText;

  /// 后缀的边距
  final EdgeInsetsGeometry? suffixPadding;

  /// 默认文本
  final String? text;

  /// 是否使用统一的边框样式
  /// 设置为 true, 会强制所有状态下使用同一种边框样式,
  /// 优先级 [border] > [enabledBorder] > [focusedBorder] > [disabledBorder] > [errorBorder] > [focusedErrorBorder],
  /// 如果都为空则使用 [InputBorder.none]
  /// 默认为 false
  final bool uniformBorderStyles;

  /// 固定宽度
  final double? width;

  InputDecoration generateInputDecoration(
    TextStyle? hintTheme,
    double? fontSize,
  ) {
    final defaultHintStyle = hintTheme?.copyWith(
      fontSize: fontSize,
      color: hintColor,
      inherit: true,
    );

    final efftiveConstraints = (width != null || height != null)
        ? constraints?.tighten(
              width: width,
              height: height,
            ) ??
            BoxConstraints.tightFor(
              width: width,
              height: height,
            )
        : constraints;

    final effectiveSuffix = suffixPadding != null && suffix != null
        ? Padding(
            padding: suffixPadding!,
            child: suffix,
          )
        : suffix;

    final effectiveSuffixIcon = suffixIconPadding != null && suffixIcon != null
        ? Padding(
            padding: suffixIconPadding!,
            child: suffixIcon,
          )
        : suffixIcon;

    return copyWith(
      hintStyle: hintStyle?.combine(defaultHintStyle) ?? defaultHintStyle,
      suffixIcon: effectiveSuffixIcon,
      suffix: effectiveSuffix,
      filled: filled ?? fillColor != null,
      errorBorder: errorBorder ?? _defaultBorder(),
      focusedBorder: focusedBorder ?? _defaultBorder(),
      focusedErrorBorder: focusedErrorBorder ?? _defaultBorder(),
      disabledBorder: disabledBorder ?? _defaultBorder(),
      enabledBorder: enabledBorder ?? _defaultBorder(),
      border: border ?? _defaultBorder(isBorder: true),
      constraints: efftiveConstraints,
    );
  }

  /// 默认边框样式
  InputBorder? _defaultBorder({
    bool isBorder = false,
  }) {
    if (borderRadius != null || radius != null || side != null) {
      final effectiveBorderRadius =
          borderRadius ?? BorderRadius.circular(radius ?? 0);
      // 默认无边框.
      // NOTE: 如果使用 [BorderSide.none] 在 UnderlineInputBorder 下也会展示出黑线, 因为 [BorderSide] 的 color 默认是黑色, 可能是 flutter 的 bug? 所以这里直接把颜色设置为透明.
      final borderSide = side ??
          const BorderSide(
            color: Colors.transparent,
            width: 0,
            style: BorderStyle.none,
          );

      if (borderStyle == MInputBorderStyle.outline) {
        return OutlineInputBorder(
          borderRadius: effectiveBorderRadius,
          borderSide: borderSide,
          gapPadding: gapPadding ?? 4.0,
        );
      }
      // 默认底部边框
      return UnderlineInputBorder(
        borderRadius: effectiveBorderRadius,
        borderSide: borderSide,
      );
    }

    final defaultBorder = isBorder
        ? borderStyle == MInputBorderStyle.outline
            ? const OutlineInputBorder()
            : const UnderlineInputBorder()
        : null;

    return uniformBorderStyles
        ? border ??
            enabledBorder ??
            focusedBorder ??
            disabledBorder ??
            errorBorder ??
            focusedErrorBorder ??
            defaultBorder
        : defaultBorder;
  }
}
