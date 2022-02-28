import 'package:flutter/material.dart';
import 'package:local_farm_backstage/core/enumKey.dart';

class UpdateResultSnakeBar {
  static void show(BuildContext context, {required Status result}) {
    String resultText = result == Status.success
        ? "更新成功"
        : result == Status.failure
            ? "更新失敗，請再試一次"
            : "";
    final snackBar = SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: Text(
          resultText,
          style: result == Status.failure
              ? const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontFamily: "NotoSansTC",
                )
              : const TextStyle(
                  fontSize: 14,
                  fontFamily: "NotoSansTC",
                ),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
