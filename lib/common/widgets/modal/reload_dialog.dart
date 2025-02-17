import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReloadDialog extends StatelessWidget {
  final VoidCallback onReload;

  const ReloadDialog({Key? key, required this.onReload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text('An error occurred while loading the data. Would you like to retry?'),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Get.back(),
        ),
        ElevatedButton(
          child: Text('Reload'),
          onPressed: () {
            Get.back();
            onReload();
          },
        ),
      ],
    );
  }
}