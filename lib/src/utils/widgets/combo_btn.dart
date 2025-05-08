import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gold_silver/src/utils/widgets/my_btn.dart';

enum ComboButtonDirectionType { row, column }

class ComboButton extends StatelessWidget {
  const ComboButton({
    super.key,
    required this.buttons,
    this.padding = EdgeInsets.zero,
    this.spacing = 16,
    this.direction = ComboButtonDirectionType.row,
  });

  final List<MyButton> buttons;
  final EdgeInsets padding;
  final double spacing;
  final ComboButtonDirectionType direction;

  @override
  Widget build(BuildContext context) {
    if (buttons.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: padding,
      child: switch (direction) {
        ComboButtonDirectionType.row => _row(),
        ComboButtonDirectionType.column => _column(),
      },
    );
  }

  Row _row() {
    return Row(
      children: buttons
          .mapIndexed(
            (i, e) => [
              Expanded(
                key: UniqueKey(),
                flex: e.flexInCombo ?? 1,
                child: e,
              ),
              if (i != buttons.length - 1) SizedBox(width: spacing),
            ],
          )
          .flattened
          .toList(),
    );
  }

  Column _column() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: buttons
          .mapIndexed(
            (i, e) => [
              SizedBox(
                key: UniqueKey(),
                child: e,
              ),
              if (i != buttons.length - 1) SizedBox(height: spacing),
            ],
          )
          .flattened
          .toList(),
    );
  }
}
