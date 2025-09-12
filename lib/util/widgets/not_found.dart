import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key, this.message = 'No data'});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Icon(
          CupertinoIcons.cube_box,
          size: 60,
          color: Colors.black.withOpacity(0.5),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          message.tr,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
