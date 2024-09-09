import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/session_manager.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ListTile(
        splashColor: Colors.transparent,
        tileColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        onTap: (){
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: darkMode ? TColors.textPrimary : Colors.white,
              context: context,
              builder: (ctx) => Container(
                width: double.infinity,
                height: 210,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.labelMedium,
                                  children: const <TextSpan> [
                                    TextSpan(
                                        text: 'Confirm Logout?',
                                        style: TextStyle(
                                            fontSize: TSizes.fontSize14,
                                        )
                                    )
                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        UserSession.instance.logoutUser(logoutMessage: 'You have successfully logged out');
                      },
                      title: SizedBox(
                        height: 60,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: const <TextSpan> [
                                      TextSpan(
                                          text: 'Log Out',
                                          style: TextStyle(
                                              fontSize: TSizes.fontSize16,
                                              fontWeight: FontWeight.w600
                                          )
                                      )
                                    ]
                                )
                            ),
                          ],
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
                      onTap: () {Get.back();},
                      title: SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: const <TextSpan> [
                                      TextSpan(
                                          text: 'Cancel',
                                          style: TextStyle(
                                              fontSize: TSizes.fontSize16,
                                              fontWeight: FontWeight.w600
                                          )
                                      )
                                    ]
                                )
                            ),
                          ],
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
                children: const <TextSpan> [
                  TextSpan(
                      text: 'Log Out',
                      style: TextStyle(
                          fontSize: TSizes.fontSize16,
                          fontWeight: FontWeight.w600
                      )
                  )
                ]
            )
        ),
      ),
    );
  }
}