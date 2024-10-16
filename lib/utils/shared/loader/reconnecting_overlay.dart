import 'package:flutter/material.dart';

class ReconnectingOverlay extends StatelessWidget {
  String? progress;

  ReconnectingOverlay(this.progress);

  @override
  Widget build(BuildContext context) =>
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text(
              'Reconnecting...',
            ),
            SizedBox(height: 12),
            Text(
              progress ?? '',
            ),
          ],
        ),
      );
}