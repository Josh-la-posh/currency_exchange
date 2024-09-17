// ignore_for_file: avoid_catches_without_on_clauses

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/home/routes/names.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/layouts/navigation_menu.dart';

import '../../../data/modules/app_navigator.dart';

class ErrorBoundary extends StatelessWidget {
  final Widget app;

  const ErrorBoundary({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    try {
      return app;
    } catch (e) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Icon(
                  Icons.error,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'An error occurred',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontFamily: 'Avenir',
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(4)),
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(TColors.primary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.8),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.offAll(() => NavigationMenu());
                  },
                  child: const Text(
                    'Please Refresh',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Avenir',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
