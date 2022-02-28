import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_farm_backstage/core/model/image_file.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({
    Key? key,
    required this.imageFile,
    required this.onDelete,
    required this.ratio,
  }) : super(key: key);
  final ImageFile imageFile;
  final VoidCallback onDelete;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: ratio,
              child: Image.memory(
                base64Decode(imageFile.base64),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(imageFile.filename),
          ],
        ),
        Positioned(
            right: 5,
            top: 5,
            child: IconButton(
              onPressed: onDelete,
              icon: Container(
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            )),
      ],
    );
  }
}
