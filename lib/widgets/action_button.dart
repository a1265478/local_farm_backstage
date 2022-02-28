import 'package:flutter/material.dart';
import 'package:local_farm_backstage/const/const.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.title = "儲存",
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kDarkGreenColor,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
