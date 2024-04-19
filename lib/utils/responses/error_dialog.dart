import 'package:flutter/material.dart';

import '../../data/modules/app_navigator.dart';

void showErrorAlertHelper(
    {required String errorMessage, VoidCallback? onClose}) {
  showDialog(
    context: AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Error',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                AppNavigator.instance.goBackNavHandler();
                if (onClose != null) {
                  onClose();
                }
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}
