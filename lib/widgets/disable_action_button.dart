import 'package:flutter/material.dart';
import 'package:local_farm_backstage/const/const.dart';

class DisableActionButton extends StatelessWidget {
  const DisableActionButton({Key? key, this.title = "儲存"}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kDisableColor,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
      onPressed: () {},
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
