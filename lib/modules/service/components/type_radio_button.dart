import 'package:flutter/material.dart';
import 'package:local_farm_backstage/const/const.dart';

class TypeRadioButton extends StatelessWidget {
  const TypeRadioButton({
    Key? key,
    required this.isSelected,
    required this.type,
    required this.onTap,
  }) : super(key: key);
  final bool isSelected;
  final String type;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ListTile(
        selected: isSelected,
        leading: isSelected
            ? const Icon(
                Icons.radio_button_checked,
                color: kDarkGreenColor,
              )
            : Icon(
                Icons.radio_button_off,
                color: Colors.black.withOpacity(0.6),
              ),
        title: Text(
          type,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isSelected ? kDarkGreenColor : Colors.black.withOpacity(0.6),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
