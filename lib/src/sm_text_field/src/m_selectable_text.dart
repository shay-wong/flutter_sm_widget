import 'dart:ui' as ui;

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/gestures.dart';

class MSelectableText extends ExtendedSelectableText {
  const MSelectableText(
    super.data, {
    super.key,
    super.focusNode,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.textScaler,
    super.showCursor = false,
    super.autofocus = false,
    @Deprecated(
      'Use `contextMenuBuilder` instead. '
      'This feature was deprecated after v3.3.0-0.5.pre.',
    )
    super.toolbarOptions,
    super.minLines,
    super.maxLines,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.selectionHeightStyle = ui.BoxHeightStyle.tight,
    super.selectionWidthStyle = ui.BoxWidthStyle.tight,
    super.dragStartBehavior = DragStartBehavior.start,
    super.enableInteractiveSelection = true,
    super.selectionControls,
    super.onTap,
    super.scrollPhysics,
    super.semanticsLabel,
    super.textHeightBehavior,
    super.textWidthBasis,
    super.onSelectionChanged,
    ExtendedEditableTextContextMenuBuilder? contextMenuBuilder,
    super.magnifierConfiguration,
    super.specialTextSpanBuilder,
  }) : super(
          extendedContextMenuBuilder: contextMenuBuilder,
        );

  const MSelectableText.rich(
    super.textSpan, {
    super.key,
    super.focusNode,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.textScaler,
    super.showCursor = false,
    super.autofocus = false,
    @Deprecated(
      'Use `contextMenuBuilder` instead. '
      'This feature was deprecated after v3.3.0-0.5.pre.',
    )
    super.toolbarOptions,
    super.minLines,
    super.maxLines,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.selectionHeightStyle = ui.BoxHeightStyle.tight,
    super.selectionWidthStyle = ui.BoxWidthStyle.tight,
    super.dragStartBehavior = DragStartBehavior.start,
    super.enableInteractiveSelection = true,
    super.selectionControls,
    super.onTap,
    super.scrollPhysics,
    super.semanticsLabel,
    super.textHeightBehavior,
    super.textWidthBasis,
    super.onSelectionChanged,
    ExtendedEditableTextContextMenuBuilder? contextMenuBuilder,
    super.magnifierConfiguration,
    super.specialTextSpanBuilder,
  }) : super.rich(
          extendedContextMenuBuilder: contextMenuBuilder,
        );
}
