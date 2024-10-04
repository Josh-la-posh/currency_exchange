import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/modules/storage_session_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class LogoutButton extends StatelessWidget {

  LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {

    UserSessionController userSessionController = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ListTile(
        splashColor: Colors.transparent,
        tileColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        onTap: () {
          Get.bottomSheet(
              backgroundColor: darkMode ? TColors.textPrimary : Colors.white,
              SizedBox(
                width: double.infinity,
                height: 210,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.labelMedium,
                            children: const [
                              TextSpan(
                                text: 'Confirm Logout?',
                                style: TextStyle(
                                  fontSize: TSizes.fontSize14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {
                        userSessionController.logoutUser(
                          logoutMessage: "You've successfully logged out of pouch. We hope to see you again soon.",
                        );
                      },
                      title: SizedBox(
                        height: 60,
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const [
                                TextSpan(
                                  text: 'Log Out',
                                  style: TextStyle(
                                    fontSize: TSizes.fontSize16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: darkMode ? Colors.black : Colors.grey.withOpacity(0.5),
                      height: 8,
                      width: double.infinity,
                    ),
                    ListTile(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => Get.back(),
                      title: SizedBox(
                        height: 30,
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const [
                                TextSpan(
                                  text: 'Cancel',
                                  style: TextStyle(
                                    fontSize: TSizes.fontSize16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          );
        },
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.labelMedium,
            children: const [
              TextSpan(
                text: 'Log Out',
                style: TextStyle(
                  fontSize: TSizes.fontSize16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}