import 'package:flutter/material.dart';
import 'package:grouping/common/colors.dart';

class RadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Widget child;

  const RadioButton({
    Key key,
    @required this.value,
    @required this.groupValue,
    this.child,
    this.onChanged,
  }) : super(key: key);

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: child,
      color: isSelected ? SelectedButton : UnselectedButton,
      textColor: isSelected ? Colors.white : const Color(0xFFA7A7A7),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isSelected ? SelectedButtonBorder : UnselectedButtonBorder,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: () => onChanged(value),
    );
  }
}
