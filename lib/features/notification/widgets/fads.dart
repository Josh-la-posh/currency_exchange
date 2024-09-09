// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pouch/data/modules/background_task.dart';
// import 'package:pouch/data/provider/notificaton_provider.dart';
// import 'package:pouch/data/provider/offer_provider.dart';
// import 'package:pouch/features/negotiation_offer/screen/my_bid_detail.dart';
// import 'package:pouch/features/notification/apis/api.dart';
// import 'package:pouch/features/notification/controller/notification_controller.dart';
// import 'package:pouch/utils/helpers/helper_functions.dart';
// import 'package:provider/provider.dart';
// import '../../../data/modules/app_navigator.dart';
// import '../../all_offer/screens/offer_details.dart';
// import '../../negotiation_offer/screen/my_offer_detail.dart';
// import '../../negotiation_offer/screen/negotiation_accept_reject.dart';
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   final NotificationController notificationController = Get.put(NotificationController());
//   late NotificationProvider notificationProvider;
//   late OfferProvider offerProvider;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     notificationController.fetchNotification();
//     notificationProvider = Provider.of<NotificationProvider>(
//         AppNavigator.instance.navigatorKey.currentContext as BuildContext,
//         listen: false
//     );
//     offerProvider = Provider.of<OfferProvider>(
//         AppNavigator.instance.navigatorKey.currentContext as BuildContext,
//         listen: false
//     );
//     NoLoaderService.instance.getUserNotification(
//         provider: notificationProvider,
//         onSuccess: () {
//           setState(() {
//             Future.delayed(
//                 Duration(seconds: 2),
//                     () => setState(() {
//                   isLoading = false;
//                 })
//             );
//           });
//         }
//     );
//     if (notificationProvider.idsArray.isNotEmpty) {
//       print(notificationProvider.idsArray);
//       NotificationService.instance.updateDeliveredNotifications(
//           notificationProvider: notificationProvider,
//           ids: notificationProvider.idsArray
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(vertical: 20),
//           child: isLoading == true
//               ? CircularProgressIndicator()
//               : notificationProvider.userNotifications.isEmpty
//               ? Text('No Notification')
//               : ListView.builder(
//             itemCount: notificationProvider.userNotifications.length,
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (_,index) {
//               final item = notificationProvider.userNotifications[index];
//               return Column(
//                 children: [
//                   ListTile(
//                     onTap: () async {
//                       await NoLoaderService.instance
//                           .getNotificationId(provider: notificationProvider, id: item.id.toString());
//                       print(item.type);
//                       if (item.type == 'SWAPPED' || item.type == 'EXPIRED') {
//                         // Get.to(() => MyOfferDetail(item: item));
//                         await NoLoaderService.instance.getMyOfferById(
//                             offerProvider: offerProvider,
//                             id: item.offerId.toString(),
//                             onSuccess: (){
//                               Get.to(() => MyOfferDetail(), arguments: offerProvider.myOffer);
//                             },
//                             onFailure: (){}
//                         );
//                       } else if (item.type == 'NEGOTIATED') {
//                         // Get.to(() => NegotiationAcceptRejectScreen(item: item));
//                         await NoLoaderService.instance.getOfferById(
//                             offerProvider: offerProvider,
//                             id: item.offerId.toString(),
//                             onSuccess: (){
//                               Get.to(() => NegotiationAcceptRejectScreen(item: offerProvider.myOffer));
//                             },
//                             onFailure: (){}
//                         );
//                       } else if (item.type == 'ACCEPT-REJECT') {
//                         await NoLoaderService.instance.getMyBidsById(
//                             offerProvider: offerProvider,
//                             id: item.offerId.toString(),
//                             onSuccess: (){
//                               Get.to(() => MyBidDetail(), arguments: offerProvider.myBid);
//                             },
//                             onFailure: (){}
//                         );
//
//                       } else {
//                         await NoLoaderService.instance.getOfferById(
//                             offerProvider: offerProvider,
//                             id: item.offerId.toString(),
//                             onSuccess: (){
//                               Get.to(() => OfferDetailsScreen());
//                             },
//                             onFailure: (){}
//                         );
//                       }
//                     },
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
//                     title: Row(
//                       children: [
//                         Container(
//                           width: 6,
//                           height: 6,
//                           decoration: BoxDecoration(
//                               color: item.read == false ? Colors.red : Colors.transparent,
//                               borderRadius: BorderRadius.circular(6)
//                           ),
//                         ),
//                         SizedBox(width: 15,),
//                         SizedBox(
//                           width: THelperFunctions.screenWidth() * 0.85,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item.description.toString(),
//                                 style: Theme.of(context).textTheme.labelMedium,
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     '${THelperFunctions.getFormattedDate(item.createdDate.toString())} ${THelperFunctions.getFormattedTime(item.createdDate.toString())}',
//                                     style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey, fontSize: 11),
//                                   ),
//                                   Spacer(),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         'View More',
//                                         style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 11),
//                                       ),
//                                       Icon(Icons.arrow_right_alt, size: 15,)
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 1,
//                     width: double.infinity,
//                     color: Colors.grey.withOpacity(0.25),
//                   )
//                 ],
//               );
//             },
//           )
//       ),
//     );
//   }
// }
