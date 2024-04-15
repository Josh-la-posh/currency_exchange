// ignore_for_file: avoid_catches_without_on_clauses

import 'package:flutter/material.dart';
import 'package:swappr/features/home/routes/names.dart';

import '../../../data/modules/app_navigator.dart';

class ErrorBoundary extends StatelessWidget {
  final Widget app;

  const ErrorBoundary({required this.app});

  @override
  Widget build(BuildContext context) {
    try {
      return app;
    } catch (e) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Icon(
                  Icons.error,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
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
                    MaterialStateProperty.all(Color(0xFF1B88DF)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.8),
                      ),
                    ),
                  ),
                  onPressed: () {
                    AppNavigator.instance
                        .removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
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
