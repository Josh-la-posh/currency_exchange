import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/features/notification/controller/notification_controller.dart';
import 'package:pouch/features/notification/screens/notification_offer_details.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';

import '../../all_offer/screens/offer_details.dart';
import '../../negotiation_offer/screen/my_bid_detail.dart';
import '../../negotiation_offer/screen/my_offer_detail.dart';
import '../../negotiation_offer/screen/negotiation_accept_reject.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController notificationController = Get.put(NotificationController());
  final OfferController offerController = Get.put(OfferController());
  late OfferProvider offerProvider;

  @override
  Widget build(BuildContext context) {
    if (notificationController.userNotifications.isEmpty) {
      notificationController.fetchNotification();
    }
    if (notificationController.idsArray.isNotEmpty) {
      notificationController.fetchNotification();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: Obx(() {
        return notificationController.isLoading.value == true
            ? Center(child: CircularProgressIndicator())
            : CustomRefreshIndicator(
            onRefresh: () => notificationController.fetchNotification(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  notificationController.userNotifications.isEmpty
                      ? Container(
                    height: THelperFunctions.screenHeight() - 100,
                    width: THelperFunctions.screenWidth(),
                    padding: EdgeInsets.only(top: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off_outlined, size: 60,),
                        SizedBox(height: 30,),
                        Text('No notifications available.'),
                      ],
                    ),
                  )
                      : ListView.builder(
                    itemCount: notificationController.userNotifications.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_,index) {
                      final item = notificationController.userNotifications[index];
                      return Column(
                        children: [
                          ListTile(
                            onTap: () async {
                              // await NoLoaderService.instance
                              //     .getNotificationId(provider: notificationProvider, id: item.id.toString());
                              print(item.type);
                              if (item.type == 'SWAPPED' || item.type == 'EXPIRED') {
                                print(item.type);
                                await offerController.fetchMyOffersById(
                                    id: item.offerId.toString(),
                                    onSuccess: () {
                                      Get.to(() => MyNotificationOfferDetail(), arguments: {
                                        'item': offerController.myOfferById
                                      });
                                    }
                                );
                              } else if (item.type == 'NEGOTIATED') {
                                print(item.type);
                                await offerController.fetchMyOffersById(
                                    id: item.offerId.toString(),
                                    onSuccess: () {
                                      Get.to(() => NegotiationAcceptRejectScreen(item: offerController.myOfferById.value));
                                    }
                                );
                              } else if (item.type == 'ACCEPT-REJECT') {
                                print(item.type);
                                await offerController.fetchMyBidsById(
                                    id: item.offerId.toString(),
                                    onSuccess: () {
                                      Get.to(() => MyBidDetail(), arguments: offerController.myBidById.value);
                                    }
                                );

                              } else {
                                print(item.type);
                                await offerController.fetchOfferById(
                                    id: item.offerId.toString(),
                                    currency: '',
                                    onSuccess: () {
                                      Get.to(() => OfferDetailsScreen());
                                    }
                                );
                              }

                              await notificationController.fetchNotificationById(id: item.id.toString());
                            },
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                                SizedBox(
                                  width: THelperFunctions.screenWidth() * 0.85,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.description.toString(),
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${THelperFunctions.getFormattedDate(item.createdDate.toString())} ${THelperFunctions.getFormattedTime(item.createdDate.toString())}',
                                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey, fontSize: 11),
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Text(
                                                'View More',
                                                style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 11),
                                              ),
                                              Icon(Icons.arrow_right_alt, size: 15,)
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
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
                ],
              ),
            )
        );
      })
    );
  }
}
