import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'text_style_extension.dart';

TextStyle _m2CounterErrorStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error);

TextStyle? _m2StateInputStyle(BuildContext context) => MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
      final ThemeData theme = Theme.of(context);
      if (states.contains(MaterialState.disabled)) {
        return TextStyle(color: theme.disabledColor);
      }
      return TextStyle(color: theme.textTheme.titleMedium?.color);
    });

TextStyle _m3CounterErrorStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error);

TextStyle _m3InputStyle(BuildContext context) => Theme.of(context).textTheme.bodyLarge!;
TextStyle? _m3StateInputStyle(BuildContext context) => MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.38));
      }
      return TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color);
    });

enum MTextFieldBorderStyle {
  underline,
  outline,
}

class MTextField extends StatefulWidget {
  /// Creates a Material Design [TextField].
  const MTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.undoController,
    this.decoration,
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.statesController,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.isBold = false,
    this.forceStrutHeight = false,
    this.filled,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.enabledBorder,
    this.border,
    this.text,
    this.fillColor,
    this.width,
    this.height,
    this.constraints,
    this.borderRadius,
    this.radius,
    this.side,
    this.borderStyle = MTextFieldBorderStyle.underline,
    this.gapPadding,
    this.icon,
    this.iconColor,
    this.label,
    this.labelText,
    this.labelStyle,
    this.floatingLabelStyle,
    this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    this.hintText,
    this.hintColor,
    this.hintStyle,
    this.hintTextDirection,
    this.hintMaxLines,
    this.hintFadeDuration,
    this.error,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.floatingLabelBehavior,
    this.floatingLabelAlignment,
    this.isCollapsed,
    this.isDense,
    this.contentPadding,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.prefix,
    this.prefixText,
    this.prefixStyle,
    this.prefixIconColor,
    this.suffixIcon,
    this.suffix,
    this.suffixText,
    this.suffixStyle,
    this.suffixIconColor,
    this.suffixIconConstraints,
    this.suffixPadding,
    this.suffixIconPadding,
    this.counter,
    this.counterText,
    this.counterStyle,
    this.alignLabelWithHint,
    this.focusColor,
    this.hoverColor,
    this.semanticCounterText,
  })  : assert(obscuringCharacter.length == 1),
        smartDashesType = smartDashesType ?? (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ?? (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1, 'Obscured fields cannot be multiline.'),
        assert(maxLength == null || maxLength == TextField.noMaxLength || maxLength > 0),
        // Assert the following instead of setting it directly to avoid surprising the user by silently changing the value they set.
        assert(
          !identical(textInputAction, TextInputAction.newline) ||
              maxLines == 1 ||
              !identical(keyboardType, TextInputType.text),
          'Use keyboardType TextInputType.multiline when using TextInputAction.newline on a multiline TextField.',
        ),
        keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        enableInteractiveSelection = enableInteractiveSelection ?? (!readOnly || !obscureText);

  static const TextStyle materialMisspelledTextStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: Colors.red,
    decorationStyle: TextDecorationStyle.wavy,
  );

  static const int noMaxLength = -1;

  final bool autocorrect;
  final Iterable<String>? autofillHints;
  final bool autofocus;
  final InputCounterWidgetBuilder? buildCounter;
  final bool canRequestFocus;
  final Clip clipBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextEditingController? controller;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final double? cursorHeight;
  final bool? cursorOpacityAnimates;
  final Radius? cursorRadius;
  final double cursorWidth;
  final InputDecoration? decoration;
  final DragStartBehavior dragStartBehavior;
  final bool enableIMEPersonalizedLearning;
  final bool enableInteractiveSelection;
  final bool enableSuggestions;
  final bool expands;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Brightness? keyboardAppearance;
  final TextInputType keyboardType;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final MouseCursor? mouseCursor;
  final bool obscureText;
  final String obscuringCharacter;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final GestureTapCallback? onTap;
  final bool onTapAlwaysCalled;
  final TapRegionCallback? onTapOutside;
  final bool readOnly;
  final String? restorationId;
  final bool scribbleEnabled;
  final ScrollController? scrollController;
  final EdgeInsets scrollPadding;
  final ScrollPhysics? scrollPhysics;
  final TextSelectionControls? selectionControls;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final bool? showCursor;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final MaterialStatesController? statesController;
  final StrutStyle? strutStyle;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextCapitalization textCapitalization;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final UndoHistoryController? undoController;

  /// 如果 [labelText] 或者 [helperText] 存在，则将此标签与它们对齐
  final bool? alignLabelWithHint;

  /// 输入框的边框, 默认情况下为 [InputBorder.none].
  /// 如果设置了[borderRadius] 或 [radius] 或 [side] 或 [gapPadding], 则根据 [borderStyle] 重新计算边框
  final InputBorder? border;

  /// 圆角
  final BorderRadius? borderRadius;

  /// 边框样式, 默认 [MTextFieldBorderStyle.underline]
  final MTextFieldBorderStyle borderStyle;

  /// 字体颜色
  final Color? color;

  /// 输入框的大小约束
  final BoxConstraints? constraints;

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
  final EdgeInsetsGeometry? contentPadding;

  /// 计数器
  final Widget? counter;

  /// 计数器的样式
  final TextStyle? counterStyle;

  /// 计数器的文本
  final String? counterText;

  /// 禁用状态下的边框
  final InputBorder? disabledBorder;

  /// 是否启用输入框
  final bool? enabled;

  /// 启用状态下的边框
  final InputBorder? enabledBorder;

  /// 错误提示
  final Widget? error;

  /// 错误状态下的边框
  final InputBorder? errorBorder;

  /// 错误提示的最大行数
  final int? errorMaxLines;

  /// 错误提示的样式
  final TextStyle? errorStyle;

  /// 错误提示的文本
  final String? errorText;

  /// 输入框填充的颜色
  final Color? fillColor;

  /// 是否填充输入框
  /// 如果为 "true"，装饰的容器将被填充为 [fillColor]。
  /// 默认为 "false", 当 [fillColor] 不为 null 时默认为 "true".
  final bool? filled;

  /// 标签的对齐方式
  final FloatingLabelAlignment? floatingLabelAlignment;

  /// 标签的行为
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// 标签的样式
  final TextStyle? floatingLabelStyle;

  /// 输入框获取焦点时的颜色
  final Color? focusColor;

  /// 获取焦点时的边框
  final InputBorder? focusedBorder;

  /// 获取焦点时的错误边框
  final InputBorder? focusedErrorBorder;

  /// 字体大小
  final double? fontSize;

  /// 字体粗细
  final FontWeight? fontWeight;

  /// 是否强制设置支柱高度。默认值为 false。
  final bool forceStrutHeight;

  /// 边框两侧的水平填充, 默认值为 4.0
  /// [InputDecoration.labelText] 宽度间隙.
  ///
  /// 此值由[paint]方法用于计算实际间隙宽度.
  final double? gapPadding;

  /// 限定文本高度, 会限定 [MTextField] 高度为 [height],
  /// 如果想设置初始高度, 在 [maxLines] > 1, 并且希望 [MTextField] 自适应高度的情况下,
  /// 推荐设置 [isDense] 为 true, 配合 [contentPadding] 来控制初始高度,
  /// 注意, [suffixIcon] 默认约束是 48x48, 如果要设置小于 48 的高度, 需要设置 [suffixIconConstraints].
  final double? height;

  /// 帮助提示的最大行数
  final int? helperMaxLines;

  /// 帮助提示的样式
  final TextStyle? helperStyle;

  /// 帮助提示的文本
  final String? helperText;

  /// 提示文字淡出动画的持续时间
  final Duration? hintFadeDuration;

  /// 提示文字的最大行数
  final int? hintMaxLines;

  /// 提示文字的样式
  final TextStyle? hintStyle;

  /// 提示文字的文本
  final String? hintText;

  /// 提示文字的方向
  final TextDirection? hintTextDirection;

  /// 鼠标悬浮时的颜色
  final Color? hoverColor;

  /// 前缀图标
  final Widget? icon;

  /// 前缀图标的颜色
  final Color? iconColor;

  /// 是否为粗体
  final bool isBold;

  /// 是否折叠
  final bool? isCollapsed;

  /// 是否紧凑
  final bool? isDense;

  /// 标签
  final Widget? label;

  /// 标签的样式
  final TextStyle? labelStyle;

  /// 标签的文本
  final String? labelText;

  /// 提示颜色
  final Color? hintColor;

  /// 前缀
  final Widget? prefix;

  /// 前缀图标
  final Widget? prefixIcon;

  /// 前缀图标的颜色
  final Color? prefixIconColor;

  /// 前缀图标的约束
  final BoxConstraints? prefixIconConstraints;

  /// 前缀的样式
  final TextStyle? prefixStyle;

  /// 前缀的文本
  final String? prefixText;

  /// 圆角半径
  final double? radius;

  /// 统计信息的文本，用于读屏软件
  final String? semanticCounterText;

  /// 边框颜色粗细等样式
  final BorderSide? side;

  /// 后缀
  final Widget? suffix;

  /// 后缀图标
  final Widget? suffixIcon;

  /// 后缀图标的颜色
  final Color? suffixIconColor;

  /// 后缀图标的约束, 比如限制宽高, 默认是 48x48, 在 [InputDecorator] 中被设置为 [kMinInteractiveDimension]
  final BoxConstraints? suffixIconConstraints;

  /// 后缀的样式
  final TextStyle? suffixStyle;

  /// 后缀的文本, 如果和 [suffixIcon] 一起使用，会显示在图标的前面
  final String? suffixText;

  /// 后缀的边距
  final EdgeInsetsGeometry? suffixPadding;

  /// 后缀图标的边距
  final EdgeInsetsGeometry? suffixIconPadding;

  /// 默认文本
  final String? text;

  /// 文本宽度
  final double? width;

  @override
  State<MTextField> createState() => _MTextFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('controller', controller, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode, defaultValue: null));
    properties.add(DiagnosticsProperty<UndoHistoryController>('undoController', undoController, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: null));
    properties
        .add(DiagnosticsProperty<InputDecoration>('decoration', decoration, defaultValue: const InputDecoration()));
    properties.add(DiagnosticsProperty<TextInputType>('keyboardType', keyboardType, defaultValue: TextInputType.text));
    properties.add(DiagnosticsProperty<TextStyle>('style', style, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false));
    properties.add(DiagnosticsProperty<String>('obscuringCharacter', obscuringCharacter, defaultValue: '•'));
    properties.add(DiagnosticsProperty<bool>('obscureText', obscureText, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('autocorrect', autocorrect, defaultValue: true));
    properties.add(EnumProperty<SmartDashesType>('smartDashesType', smartDashesType,
        defaultValue: obscureText ? SmartDashesType.disabled : SmartDashesType.enabled));
    properties.add(EnumProperty<SmartQuotesType>('smartQuotesType', smartQuotesType,
        defaultValue: obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled));
    properties.add(DiagnosticsProperty<bool>('enableSuggestions', enableSuggestions, defaultValue: true));
    properties.add(IntProperty('maxLines', maxLines, defaultValue: 1));
    properties.add(IntProperty('minLines', minLines, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('expands', expands, defaultValue: false));
    properties.add(IntProperty('maxLength', maxLength, defaultValue: null));
    properties
        .add(EnumProperty<MaxLengthEnforcement>('maxLengthEnforcement', maxLengthEnforcement, defaultValue: null));
    properties.add(EnumProperty<TextInputAction>('textInputAction', textInputAction, defaultValue: null));
    properties.add(EnumProperty<TextCapitalization>('textCapitalization', textCapitalization,
        defaultValue: TextCapitalization.none));
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: TextAlign.start));
    properties.add(DiagnosticsProperty<TextAlignVertical>('textAlignVertical', textAlignVertical, defaultValue: null));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(DoubleProperty('cursorWidth', cursorWidth, defaultValue: 2.0));
    properties.add(DoubleProperty('cursorHeight', cursorHeight, defaultValue: null));
    properties.add(DiagnosticsProperty<Radius>('cursorRadius', cursorRadius, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('cursorOpacityAnimates', cursorOpacityAnimates, defaultValue: null));
    properties.add(ColorProperty('cursorColor', cursorColor, defaultValue: null));
    properties.add(ColorProperty('cursorErrorColor', cursorErrorColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Brightness>('keyboardAppearance', keyboardAppearance, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('scrollPadding', scrollPadding,
        defaultValue: const EdgeInsets.all(20.0)));
    properties.add(
        FlagProperty('selectionEnabled', value: selectionEnabled, defaultValue: true, ifFalse: 'selection disabled'));
    properties
        .add(DiagnosticsProperty<TextSelectionControls>('selectionControls', selectionControls, defaultValue: null));
    properties.add(DiagnosticsProperty<ScrollController>('scrollController', scrollController, defaultValue: null));
    properties.add(DiagnosticsProperty<ScrollPhysics>('scrollPhysics', scrollPhysics, defaultValue: null));
    properties.add(DiagnosticsProperty<Clip>('clipBehavior', clipBehavior, defaultValue: Clip.hardEdge));
    properties.add(DiagnosticsProperty<bool>('scribbleEnabled', scribbleEnabled, defaultValue: true));
    properties.add(
        DiagnosticsProperty<bool>('enableIMEPersonalizedLearning', enableIMEPersonalizedLearning, defaultValue: true));
    properties.add(DiagnosticsProperty<SpellCheckConfiguration>('spellCheckConfiguration', spellCheckConfiguration,
        defaultValue: null));
    properties.add(DiagnosticsProperty<List<String>>(
        'contentCommitMimeTypes', contentInsertionConfiguration?.allowedMimeTypes ?? const <String>[],
        defaultValue: contentInsertionConfiguration == null ? const <String>[] : kDefaultContentInsertionMimeTypes));
    // TODO: add custom properties
  }

  bool get selectionEnabled => enableInteractiveSelection;

  @visibleForTesting
  static Widget defaultSpellCheckSuggestionsToolbarBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoSpellCheckSuggestionsToolbar.editableText(
          editableTextState: editableTextState,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return SpellCheckSuggestionsToolbar.editableText(
          editableTextState: editableTextState,
        );
    }
  }

  static SpellCheckConfiguration inferAndroidSpellCheckConfiguration(
    SpellCheckConfiguration? configuration,
  ) {
    if (configuration == null || configuration == const SpellCheckConfiguration.disabled()) {
      return const SpellCheckConfiguration.disabled();
    }
    return configuration.copyWith(
      misspelledTextStyle: configuration.misspelledTextStyle ?? TextField.materialMisspelledTextStyle,
      spellCheckSuggestionsToolbarBuilder:
          configuration.spellCheckSuggestionsToolbarBuilder ?? MTextField.defaultSpellCheckSuggestionsToolbarBuilder,
    );
  }

  static Widget _defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }
}

class _MTextFieldState extends State<MTextField>
    with RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  @override
  final GlobalKey<EditableTextState> editableTextKey = GlobalKey<EditableTextState>();

  // API for TextSelectionGestureDetectorBuilderDelegate.
  @override
  late bool forcePressEnabled;

  // Material states controller.
  MaterialStatesController? _internalStatesController;

  bool _isHovering = false;
  late _TextFieldSelectionGestureDetectorBuilder _selectionGestureDetectorBuilder;
  bool _showSelectionHandles = false;

  RestorableTextEditingController? _controller;
  FocusNode? _focusNode;

  @override
  void autofill(TextEditingValue newEditingValue) => _editableText!.autofill(newEditingValue);

  // AutofillClient implementation start.
  @override
  String get autofillId => _editableText!.autofillId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _effectiveFocusNode.canRequestFocus = _canRequestFocus;
  }

  @override
  void didUpdateWidget(MTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }

    _effectiveFocusNode.canRequestFocus = _canRequestFocus;

    if (_effectiveFocusNode.hasFocus && widget.readOnly != oldWidget.readOnly && _isEnabled) {
      if (_effectiveController.selection.isCollapsed) {
        _showSelectionHandles = !widget.readOnly;
      }
    }

    if (widget.statesController == oldWidget.statesController) {
      _statesController.update(MaterialState.disabled, !_isEnabled);
      _statesController.update(MaterialState.hovered, _isHovering);
      _statesController.update(MaterialState.focused, _effectiveFocusNode.hasFocus);
      _statesController.update(MaterialState.error, _hasError);
    } else {
      oldWidget.statesController?.removeListener(_handleStatesControllerChange);
      if (widget.statesController != null) {
        _internalStatesController?.dispose();
        _internalStatesController = null;
      }
      _initStatesController();
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    _statesController.removeListener(_handleStatesControllerChange);
    _internalStatesController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder = _TextFieldSelectionGestureDetectorBuilder(state: this);
    if (widget.controller == null) {
      _createLocalController();
    }
    _effectiveFocusNode.canRequestFocus = widget.canRequestFocus && _isEnabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
    _initStatesController();
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  @override
  bool get selectionEnabled => widget.selectionEnabled;

  @override
  TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints = widget.autofillHints?.toList(growable: false);
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: _effectiveController.value,
            hintText: (widget.decoration ?? _defaultDecoration).hintText,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration.copyWith(autofillConfiguration: autofillConfiguration);
  }

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeNavigationModeOf(context) ?? NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return widget.canRequestFocus && _isEnabled;
      case NavigationMode.directional:
        return true;
    }
  }

  int get _currentLength => _effectiveController.value.text.characters.length;
  InputBorder? get _defaultBorder {
    if (widget.borderRadius != null || widget.radius != null || widget.side != null) {
      final borderRadius = widget.borderRadius ?? BorderRadius.circular(widget.radius ?? 0);
      // 默认无边框.
      // NOTE: 如果使用 [BorderSide.none] 在 UnderlineInputBorder 下也会展示出黑线, 因为 [BorderSide] 的 color 默认是黑色, 可能是 flutter 的 bug? 所以这里直接把颜色设置为透明.
      final borderSide = widget.side ??
          const BorderSide(
            color: Colors.transparent,
            width: 0,
            style: BorderStyle.none,
          );

      if (widget.borderStyle == MTextFieldBorderStyle.outline) {
        return OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,
          gapPadding: widget.gapPadding ?? 4.0,
        );
      }
      // 默认底部边框
      return UnderlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      );
    }

    return InputBorder.none;
  }

  // 默认装饰
  InputDecoration get _defaultDecoration {
    final hintTheme = _hintStyle;

    final hintStyle = hintTheme.copyWith(
      fontSize: widget.fontSize,
      color: widget.hintColor,
      inherit: true,
    );

    final constraints = (widget.width != null || widget.height != null)
        ? widget.constraints?.tighten(width: widget.width, height: widget.height) ??
            BoxConstraints.tightFor(width: widget.width, height: widget.height)
        : widget.constraints;

    var suffix = widget.suffix;
    if (widget.suffixPadding != null && widget.suffix != null) {
      suffix = Padding(padding: widget.suffixPadding!, child: widget.suffix);
    }
    var suffixIcon = widget.suffixIcon;
    if (widget.suffixIconPadding != null && widget.suffixIcon != null) {
      suffixIcon = Padding(padding: widget.suffixIconPadding!, child: widget.suffixIcon);
    }

    return InputDecoration(
      icon: widget.icon,
      iconColor: widget.iconColor,
      label: widget.label,
      labelText: widget.labelText,
      labelStyle: widget.labelStyle,
      floatingLabelStyle: widget.floatingLabelStyle,
      helperText: widget.helperText,
      helperStyle: widget.helperStyle,
      helperMaxLines: widget.helperMaxLines,
      hintText: widget.hintText,
      hintStyle: widget.hintStyle?.combine(hintStyle) ?? hintStyle,
      hintTextDirection: widget.hintTextDirection,
      hintMaxLines: widget.hintMaxLines,
      hintFadeDuration: widget.hintFadeDuration,
      error: widget.error,
      errorText: widget.errorText,
      errorStyle: widget.errorStyle,
      errorMaxLines: widget.errorMaxLines,
      floatingLabelBehavior: widget.floatingLabelBehavior,
      floatingLabelAlignment: widget.floatingLabelAlignment,
      isCollapsed: widget.isCollapsed,
      isDense: widget.isDense,
      contentPadding: widget.contentPadding, // 无边距
      prefixIcon: widget.prefixIcon,
      prefixIconConstraints: widget.prefixIconConstraints,
      prefix: widget.prefix,
      prefixText: widget.prefixText,
      prefixStyle: widget.prefixStyle,
      prefixIconColor: widget.prefixIconColor,
      suffixIcon: suffixIcon,
      suffix: suffix,
      suffixText: widget.suffixText,
      suffixStyle: widget.suffixStyle,
      suffixIconColor: widget.suffixIconColor,
      suffixIconConstraints: widget.suffixIconConstraints,
      counter: widget.counter,
      counterText: widget.counterText,
      counterStyle: widget.counterStyle,
      filled: widget.filled ?? widget.fillColor != null,
      fillColor: widget.fillColor,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      errorBorder: widget.errorBorder ?? _defaultBorder,
      focusedBorder: widget.focusedBorder ?? _defaultBorder,
      focusedErrorBorder: widget.focusedErrorBorder ?? _defaultBorder,
      disabledBorder: widget.disabledBorder ?? _defaultBorder,
      enabledBorder: widget.enabledBorder ?? _defaultBorder,
      border: widget.border ?? _defaultBorder,
      enabled: widget.enabled ?? true,
      semanticCounterText: widget.semanticCounterText,
      alignLabelWithHint: widget.alignLabelWithHint,
      constraints: constraints,
    );
  }

  TextStyle? get _defaultTextStyle {
    if (widget.color != null || widget.fontSize != null || widget.fontWeight != null || widget.isBold) {
      return TextStyle(
        color: widget.color,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight ?? (widget.isBold ? FontWeight.bold : null),
        inherit: true,
      );
    }
    return null;
  }

  EditableTextState? get _editableText => editableTextKey.currentState;
  TextEditingController get _effectiveController => widget.controller ?? _controller!.value;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());
  MaxLengthEnforcement get _effectiveMaxLengthEnforcement =>
      widget.maxLengthEnforcement ??
      LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(Theme.of(context).platform);

  Color get _errorColor =>
      widget.cursorErrorColor ?? widget.decoration?.errorStyle?.color ?? Theme.of(context).colorScheme.error;

  bool get _hasError => widget.decoration?.errorText != null || widget.decoration?.error != null || _hasIntrinsicError;
  bool get _hasIntrinsicError =>
      widget.maxLength != null &&
      widget.maxLength! > 0 &&
      (widget.controller == null
          ? !restorePending && _effectiveController.value.text.characters.length > widget.maxLength!
          : _effectiveController.value.text.characters.length > widget.maxLength!);

  // 自定义方法
  TextStyle get _hintStyle => MaterialStateTextStyle.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return TextStyle(color: Theme.of(context).disabledColor);
          }
          return TextStyle(color: Theme.of(context).hintColor);
        },
      );

  // End of API for TextSelectionGestureDetectorBuilderDelegate.

  bool get _isEnabled => widget.enabled ?? widget.decoration?.enabled ?? true;

  MaterialStatesController get _statesController => widget.statesController ?? _internalStatesController!;
  bool get needsCounter =>
      widget.maxLength != null && widget.decoration != null && widget.decoration!.counterText == null;

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    // NOTE: 默认 text 传入
    _controller = value == null
        ? RestorableTextEditingController(text: widget.text)
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  InputDecoration _getEffectiveDecoration() {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);
    final InputDecoration effectiveDecoration =
        (widget.decoration ?? _defaultDecoration).applyDefaults(themeData.inputDecorationTheme).copyWith(
              enabled: _isEnabled,
              hintMaxLines: widget.decoration?.hintMaxLines ?? widget.maxLines,
            );

    // No need to build anything if counter or counterText were given directly.
    if (effectiveDecoration.counter != null || effectiveDecoration.counterText != null) {
      return effectiveDecoration;
    }

    // If buildCounter was provided, use it to generate a counter widget.
    Widget? counter;
    final int currentLength = _currentLength;
    if (effectiveDecoration.counter == null && effectiveDecoration.counterText == null && widget.buildCounter != null) {
      final bool isFocused = _effectiveFocusNode.hasFocus;
      final Widget? builtCounter = widget.buildCounter!(
        context,
        currentLength: currentLength,
        maxLength: widget.maxLength,
        isFocused: isFocused,
      );
      // If buildCounter returns null, don't add a counter widget to the field.
      if (builtCounter != null) {
        counter = Semantics(
          container: true,
          liveRegion: isFocused,
          child: builtCounter,
        );
      }
      return effectiveDecoration.copyWith(counter: counter);
    }

    if (widget.maxLength == null) {
      return effectiveDecoration;
    } // No counter widget

    String counterText = '$currentLength';
    String semanticCounterText = '';

    // Handle a real maxLength (positive number)
    if (widget.maxLength! > 0) {
      // Show the maxLength in the counter
      counterText += '/${widget.maxLength}';
      final int remaining = (widget.maxLength! - currentLength).clamp(0, widget.maxLength!);
      semanticCounterText = localizations.remainingTextFieldCharacterCount(remaining);
    }

    if (_hasIntrinsicError) {
      return effectiveDecoration.copyWith(
        errorText: effectiveDecoration.errorText ?? '',
        counterStyle: effectiveDecoration.errorStyle ??
            (themeData.useMaterial3 ? _m3CounterErrorStyle(context) : _m2CounterErrorStyle(context)),
        counterText: counterText,
        semanticCounterText: semanticCounterText,
      );
    }

    return effectiveDecoration.copyWith(
      counterText: counterText,
      semanticCounterText: semanticCounterText,
    );
  }

  // AutofillClient implementation end.

  TextStyle _getInputStyleForState(TextStyle style) {
    final ThemeData theme = Theme.of(context);
    final TextStyle stateStyle = MaterialStateProperty.resolveAs(
        theme.useMaterial3 ? _m3StateInputStyle(context)! : _m2StateInputStyle(context)!, _statesController.value);
    final TextStyle providedStyle = MaterialStateProperty.resolveAs(style, _statesController.value);
    return providedStyle.merge(stateStyle);
  }

  void _handleFocusChanged() {
    setState(() {
      // Rebuild the widget on focus change to show/hide the text selection
      // highlight.
    });
    _statesController.update(MaterialState.focused, _effectiveFocusNode.hasFocus);
  }

  void _handleHover(bool hovering) {
    if (hovering != _isHovering) {
      setState(() {
        _isHovering = hovering;
      });
      _statesController.update(MaterialState.hovered, _isHovering);
    }
  }

  void _handleSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress) {
          _editableText?.bringIntoView(selection.extent);
        }
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText?.hideToolbar();
        }
    }
  }

  void _handleSelectionHandleTapped() {
    if (_effectiveController.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  void _handleStatesControllerChange() {
    // Force a rebuild to resolve MaterialStateProperty properties.
    setState(() {});
  }

  void _initStatesController() {
    if (widget.statesController == null) {
      _internalStatesController = MaterialStatesController();
    }
    _statesController.update(MaterialState.disabled, !_isEnabled);
    _statesController.update(MaterialState.hovered, _isHovering);
    _statesController.update(MaterialState.focused, _effectiveFocusNode.hasFocus);
    _statesController.update(MaterialState.error, _hasError);
    _statesController.addListener(_handleStatesControllerChange);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (widget.readOnly && _effectiveController.selection.isCollapsed) {
      return false;
    }

    if (!_isEnabled) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.scribble) {
      return true;
    }

    if (_effectiveController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasDirectionality(context));
    assert(
      !(widget.style != null &&
          !widget.style!.inherit &&
          (widget.style!.fontSize == null || widget.style!.textBaseline == null)),
      'inherit false style must supply fontSize and textBaseline',
    );

    final ThemeData theme = Theme.of(context);
    final DefaultSelectionStyle selectionStyle = DefaultSelectionStyle.of(context);
    final TextStyle? providedStyle =
        MaterialStateProperty.resolveAs(widget.style, _statesController.value)?.combine(_defaultTextStyle) ??
            _defaultTextStyle;
    final TextStyle style =
        _getInputStyleForState(theme.useMaterial3 ? _m3InputStyle(context) : theme.textTheme.titleMedium!)
            .merge(providedStyle);
    final strutStyle = (widget.strutStyle == null && widget.forceStrutHeight)
        ? StrutStyle.fromTextStyle(style, forceStrutHeight: true)
        : widget.strutStyle;
    final Brightness keyboardAppearance = widget.keyboardAppearance ?? theme.brightness;
    final TextEditingController controller = _effectiveController;
    final FocusNode focusNode = _effectiveFocusNode;
    final List<TextInputFormatter> formatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];

    // Set configuration as disabled if not otherwise specified. If specified,
    // ensure that configuration uses the correct style for misspelled words for
    // the current platform, unless a custom style is specified.
    final SpellCheckConfiguration spellCheckConfiguration;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        spellCheckConfiguration = CupertinoTextField.inferIOSSpellCheckConfiguration(
          widget.spellCheckConfiguration,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        spellCheckConfiguration = TextField.inferAndroidSpellCheckConfiguration(
          widget.spellCheckConfiguration,
        );
    }

    TextSelectionControls? textSelectionControls = widget.selectionControls;
    final bool paintCursorAboveText;
    bool? cursorOpacityAnimates = widget.cursorOpacityAnimates;
    Offset? cursorOffset;
    final Color cursorColor;
    final Color selectionColor;
    Color? autocorrectionTextRectColor;
    Radius? cursorRadius = widget.cursorRadius;
    VoidCallback? handleDidGainAccessibilityFocus;
    VoidCallback? handleDidLoseAccessibilityFocus;

    switch (theme.platform) {
      case TargetPlatform.iOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = true;
        textSelectionControls ??= cupertinoTextSelectionHandleControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates ??= true;
        cursorColor =
            _hasError ? _errorColor : widget.cursorColor ?? selectionStyle.cursorColor ?? cupertinoTheme.primaryColor;
        selectionColor = selectionStyle.selectionColor ?? cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(iOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context), 0);
        autocorrectionTextRectColor = selectionColor;

      case TargetPlatform.macOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = false;
        textSelectionControls ??= cupertinoDesktopTextSelectionHandleControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates ??= false;
        cursorColor =
            _hasError ? _errorColor : widget.cursorColor ?? selectionStyle.cursorColor ?? cupertinoTheme.primaryColor;
        selectionColor = selectionStyle.selectionColor ?? cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(iOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context), 0);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
        handleDidLoseAccessibilityFocus = () {
          _effectiveFocusNode.unfocus();
        };

      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        forcePressEnabled = false;
        textSelectionControls ??= materialTextSelectionHandleControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor =
            _hasError ? _errorColor : widget.cursorColor ?? selectionStyle.cursorColor ?? theme.colorScheme.primary;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);

      case TargetPlatform.linux:
        forcePressEnabled = false;
        textSelectionControls ??= desktopTextSelectionHandleControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor =
            _hasError ? _errorColor : widget.cursorColor ?? selectionStyle.cursorColor ?? theme.colorScheme.primary;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
        handleDidLoseAccessibilityFocus = () {
          _effectiveFocusNode.unfocus();
        };

      case TargetPlatform.windows:
        forcePressEnabled = false;
        textSelectionControls ??= desktopTextSelectionHandleControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor =
            _hasError ? _errorColor : widget.cursorColor ?? selectionStyle.cursorColor ?? theme.colorScheme.primary;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
        handleDidLoseAccessibilityFocus = () {
          _effectiveFocusNode.unfocus();
        };
    }

    Widget child = RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: EditableText(
          key: editableTextKey,
          readOnly: widget.readOnly || !_isEnabled,
          showCursor: widget.showCursor,
          showSelectionHandles: _showSelectionHandles,
          controller: controller,
          focusNode: focusNode,
          undoController: widget.undoController,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          style: style,
          strutStyle: strutStyle,
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          autofocus: widget.autofocus,
          obscuringCharacter: widget.obscuringCharacter,
          obscureText: widget.obscureText,
          autocorrect: widget.autocorrect,
          smartDashesType: widget.smartDashesType,
          smartQuotesType: widget.smartQuotesType,
          enableSuggestions: widget.enableSuggestions,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          expands: widget.expands,
          // Only show the selection highlight when the text field is focused.
          selectionColor: focusNode.hasFocus ? selectionColor : null,
          selectionControls: widget.selectionEnabled ? textSelectionControls : null,
          onChanged: widget.onChanged,
          onSelectionChanged: _handleSelectionChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          onAppPrivateCommand: widget.onAppPrivateCommand,
          onSelectionHandleTapped: _handleSelectionHandleTapped,
          onTapOutside: widget.onTapOutside,
          inputFormatters: formatters,
          rendererIgnoresPointer: true,
          mouseCursor: MouseCursor.defer, // TextField will handle the cursor
          cursorWidth: widget.cursorWidth,
          cursorHeight: widget.cursorHeight,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor,
          selectionHeightStyle: widget.selectionHeightStyle,
          selectionWidthStyle: widget.selectionWidthStyle,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorOffset: cursorOffset,
          paintCursorAboveText: paintCursorAboveText,
          backgroundCursorColor: CupertinoColors.inactiveGray,
          scrollPadding: widget.scrollPadding,
          keyboardAppearance: keyboardAppearance,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          dragStartBehavior: widget.dragStartBehavior,
          scrollController: widget.scrollController,
          scrollPhysics: widget.scrollPhysics,
          autofillClient: this,
          autocorrectionTextRectColor: autocorrectionTextRectColor,
          clipBehavior: widget.clipBehavior,
          restorationId: 'editable',
          scribbleEnabled: widget.scribbleEnabled,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          contextMenuBuilder: widget.contextMenuBuilder,
          spellCheckConfiguration: spellCheckConfiguration,
          magnifierConfiguration: widget.magnifierConfiguration ?? TextMagnifier.adaptiveMagnifierConfiguration,
        ),
      ),
    );

    // if (widget.decoration != null) {
    child = AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[focusNode, controller]),
      builder: (BuildContext context, Widget? child) {
        return InputDecorator(
          decoration: _getEffectiveDecoration(),
          baseStyle: widget.style,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          isHovering: _isHovering,
          isFocused: focusNode.hasFocus,
          isEmpty: controller.value.text.isEmpty,
          expands: widget.expands,
          child: child,
        );
      },
      child: child,
    );
    // }
    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.textable,
      _statesController.value,
    );

    final int? semanticsMaxValueLength;
    if (_effectiveMaxLengthEnforcement != MaxLengthEnforcement.none &&
        widget.maxLength != null &&
        widget.maxLength! > 0) {
      semanticsMaxValueLength = widget.maxLength;
    } else {
      semanticsMaxValueLength = null;
    }

    return MouseRegion(
      cursor: effectiveMouseCursor,
      onEnter: (PointerEnterEvent event) => _handleHover(true),
      onExit: (PointerExitEvent event) => _handleHover(false),
      child: TextFieldTapRegion(
        child: IgnorePointer(
          ignoring: !_isEnabled,
          child: AnimatedBuilder(
            animation: controller, // changes the _currentLength
            builder: (BuildContext context, Widget? child) {
              return Semantics(
                maxValueLength: semanticsMaxValueLength,
                currentValueLength: _currentLength,
                onTap: widget.readOnly
                    ? null
                    : () {
                        if (!_effectiveController.selection.isValid) {
                          _effectiveController.selection =
                              TextSelection.collapsed(offset: _effectiveController.text.length);
                        }
                        _requestKeyboard();
                      },
                onDidGainAccessibilityFocus: handleDidGainAccessibilityFocus,
                onDidLoseAccessibilityFocus: handleDidLoseAccessibilityFocus,
                child: child,
              );
            },
            child: _selectionGestureDetectorBuilder.buildGestureDetector(
              behavior: HitTestBehavior.translucent,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _TextFieldSelectionGestureDetectorBuilder extends TextSelectionGestureDetectorBuilder {
  _TextFieldSelectionGestureDetectorBuilder({
    required _MTextFieldState state,
  })  : _state = state,
        super(delegate: state);

  final _MTextFieldState _state;

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required.
  }

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          Feedback.forLongPress(_state.context);
      }
    }
  }

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    super.onSingleTapUp(details);
    _state._requestKeyboard();
  }

  @override
  void onUserTap() {
    _state.widget.onTap?.call();
  }

  @override
  bool get onUserTapAlwaysCalled => _state.widget.onTapAlwaysCalled;
}
