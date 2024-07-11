import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/image_strings.dart';

import '../../data/modules/app_navigator.dart';

void showSuccessAlertHelper({required String successMessage, String? title}) {
  showDialog(
    context: AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: TColors.primary),
            const SizedBox(width: 8),
            Text(
              title != null ? title : 'Success',
              softWrap: true,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              successMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                AppNavigator.instance.goBackNavHandler();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}

void showSuccessAlertHelperWithoutHeader({required String successMessage}) {
  showDialog(
    context: AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              successMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                AppNavigator.instance.goBackNavHandler();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}

void showSuccessAlertHelperWithGif(
    {required String successMessage, String? title}) async {
  showDialog(
    context: AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: Colors.white,
          content: SuccessGifWidget(successMessage: successMessage));
    },
  );
}

class SuccessGifWidget extends StatefulWidget {
  final String successMessage;
  const SuccessGifWidget({super.key, required this.successMessage});

  @override
  State<SuccessGifWidget> createState() => _SuccessGifWidgetState();
}

class _SuccessGifWidgetState extends State<SuccessGifWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 100,
          child: const Image(image: AssetImage(TImages.success)),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          widget.successMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            AppNavigator.instance.goBackNavHandler();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
