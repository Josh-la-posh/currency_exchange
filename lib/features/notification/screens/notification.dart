import 'package:flutter/material.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/data/provider/notificaton_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/modules/app_navigator.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationProvider notificationProvider;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    notificationProvider = Provider.of<NotificationProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext,
        listen: false
    );
    if (notificationProvider.userNotifications.isEmpty) {
      setState(() {
        isLoading = true;
      });
      NoLoaderService.instance.getUserNotification(
          provider: notificationProvider,
          onSuccess: () {
            setState(() {
              Future.delayed(
                  Duration(seconds: 2),
                      () => setState(() {
                    isLoading = false;
                  })
              );
            });
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: isLoading == true
            ? CircularProgressIndicator()
            : notificationProvider.userNotifications.isEmpty
            ? Text('No Notification')
            : ListView.builder(
          itemCount: notificationProvider.userNotifications.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_,index) {
            final item = notificationProvider.userNotifications[index];
            return Column(
              children: [
                ListTile(
                  onTap: (){
                    NoLoaderService.instance
                        .getNotificationId(provider: notificationProvider, id: item.id.toString());
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  title: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: item.read == false ? Colors.red : Colors.transparent,
                          borderRadius: BorderRadius.circular(6)
                        ),
                      ),
                      SizedBox(width: 15,),
                      Text(
                          item.description.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.25),
                )
              ],
            );
          },
        )
      ),
    );
  }
}
