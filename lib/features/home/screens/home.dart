import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/features/home/widgets/app_drawer.dart';
import 'package:pouch/features/negotiation_offer/screen/bid_and_offer.dart';
import 'package:pouch/features/negotiation_offer/screen/my_bid.dart';
import 'package:pouch/features/negotiation_offer/screen/my_offer.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/verify_your_account.dart';
import 'package:pouch/data/modules/app_navigator.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/data/provider/auth_provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/data/provider/verification_provider.dart';
import 'package:pouch/features/all_offer/models/offer.dart';
import 'package:pouch/features/home/widgets/my_home_balance.dart';
import 'package:pouch/features/home/widgets/sections.dart';
import 'package:pouch/features/home/widgets/trending_offer.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/layouts/navigation_menu.dart';
import '../../wallet/models/default_wallet_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WalletProvider walletProvider = Provider.of<WalletProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );
  OfferProvider offerProvider = Provider.of<OfferProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    listen: false
  );
  AuthProvider authProvider = Provider.of<AuthProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );
  VerificationProvider verifyProvider = Provider.of<VerificationProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );
  TransactionProvider transactionProvider = Provider.of<TransactionProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );

  bool displayBalance = false;
  bool displayOffer = false;
  bool displayMyOffer = false;
  bool displayMyBid = false;

  @override
  void initState() {
    if (walletProvider.defaultWallet == null) {
      NoLoaderService.instance.getDefaultWallet(
          walletProvider: walletProvider,
          transactionProvider: transactionProvider
      );
      setState(() {
        displayBalance = false;
      });
      Future.delayed(
          Duration(seconds: 5),
              () => handleShowBalance()
      );
      Future.delayed(
          Duration(seconds: 3),
              () => fetchDefaultWallet
      );
    } else {
      setState(() {
        displayBalance = true;
      });
    }

    if (offerProvider.offers.isEmpty) {
      NoLoaderService.instance.getAllOffers(
          offerProvider: offerProvider,
          onSuccess: (){
            Future.delayed(
                Duration(seconds: 3),
                    () => handleShowOffer()
            );
            Future.delayed(
                Duration(seconds: 2),
                    () => fetchDefaultWallet
            );
          },
          onFailure: (){
            setState(() {
              displayOffer = true;
            });
          }
      );
    } else {
      setState(() {
        displayOffer = true;
      });
    }

    if (offerProvider.myBids.isEmpty) {
      NoLoaderService.instance.getMyBids(
          offerProvider: offerProvider,
          days: '', currency: '',
          onSuccess: () {
            Future.delayed(
              Duration(seconds: 2),
                () => setState(() {
                  displayMyBid = true;
                })
            );
          },
          onFailure: () {
            setState(() {
              displayMyBid = true;
            });
          }
      );
      setState(() {
        displayMyBid = false;
      });
    } else {
      setState(() {
        displayMyBid = true;
      });
    }

    if (offerProvider.myOffers.isEmpty) {
      NoLoaderService.instance.getMyOffers(
          offerProvider: offerProvider,
          days: '',
          currency: '',
          onFailure: (){
            setState(() {
              displayMyOffer = true;
            });
          },
          onSuccess: (){
            Future.delayed(
                Duration(seconds: 2),
                    () => setState(() {
                  displayMyOffer = true;
                })
            );
          }
      );
      setState(() {
        displayMyOffer = false;
      });
    } else {
      setState(() {
        displayMyOffer = true;
      });
    }

    if (authProvider.user?.isVerified == false) {
      setState(() {
        verifyProvider.showVerifyModal = true;
      });
    }
    super.initState();
  }

  Future<void> _refreshPage() async {
    await NoLoaderService.instance.getDefaultWallet(
        walletProvider: walletProvider,
        transactionProvider: transactionProvider
    );
    await NoLoaderService.instance.getAllOffers(
        offerProvider: offerProvider,
        onFailure: (){
          setState(() {
            displayOffer = true;
          });
          },
        onSuccess: (){
          Future.delayed(
            Duration(seconds: 2),
              () => setState(() {
                displayOffer = true;
              })
          );
        }
    );
    setState(() {
      displayOffer = false;
    });
    await NoLoaderService.instance.getMyOffers(
        offerProvider: offerProvider,
        days: '',
        currency: '',
        onFailure: (){
          setState(() {
            displayMyOffer = true;
          });
        },
        onSuccess: (){
          Future.delayed(
              Duration(seconds: 2),
                  () => setState(() {
                displayMyOffer = true;
              })
          );
        }
    );
    await NoLoaderService.instance.getMyBids(
        offerProvider: offerProvider,
        days: '',
        currency: '',
        onFailure: (){
          setState(() {
            displayMyBid = true;
          });
        },
        onSuccess: (){
          Future.delayed(
              Duration(seconds: 2),
                  () => setState(() {
                displayMyBid = true;
              })
          );
        }
    );
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> fetchDefaultWallet()  async {
    try {
      if (walletProvider.defaultWallet == null) {
        DefaultWalletModel? defaultWalletDetail = await walletProvider.defaultWallet;
        setState(() {
          walletProvider.defaultWalletDetail = defaultWalletDetail;
          displayBalance = true;
        });
      } else {
        DefaultWalletModel? defaultWalletDetail = await walletProvider.defaultWallet;
        setState(() {
          walletProvider.defaultWalletDetail = defaultWalletDetail;
          displayBalance = true;
        });
      }
    } catch (e) {
      print('Error fetching wallet: $e');
    }
  }

  Future<void> fetchAllOffers()  async {
    try {
      if (offerProvider.offers.isEmpty) {
        List<OfferEntity>? offers = await offerProvider.offers;
        setState(() {
          offerProvider.tOffers = offers;
          displayOffer = true;
        });
      } else {
        List<OfferEntity>? offers = await offerProvider.offers;
        setState(() {
          offerProvider.tOffers = offers;
          displayOffer = true;
        });
      }
    } catch (e) {
      print('Error fetching offers: $e');
    }
  }

  void handleShowBalance() {
    setState(() {
      displayBalance = true;
    });
  }

  void handleShowOffer() {
    setState(() {
      displayOffer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(NavigationController());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.01),
        appBar: AppBar(
          backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
          leading: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                child: IconButton(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () =>
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => AppDrawerWidget(darkMode: darkMode),
                                transitionDuration: Duration(milliseconds: 500) ,
                                transitionsBuilder: (_, a, __, c) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  return SlideTransition(position: a.drive(tween), child: c,);
                                }
                            )
                        ),
                    icon: Icon(Icons.person_pin, color: TColors.primary, size: 35,)
                ),
              )
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: TSizes.defaultSpace),
              child: Icon(Iconsax.notification4, size: 30,),
            )
          ],
        ),
        // drawer: AppDrawerWidget(darkMode: darkMode,),
        body: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1),
              )
            )
          ),
          child: CustomRefreshIndicator(
            onRefresh: _refreshPage,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: darkMode ? TColors.textPrimaryO40 : Colors.white,
                    width: double.infinity,
                    child: Column(
                      children: [
                        verifyProvider.showVerifyModal == true
                            ? VerifyYourAccountWidget(
                          darkMode: darkMode,
                          onTap: () {
                            setState(() {
                              verifyProvider.showVerifyModal = !verifyProvider.showVerifyModal;
                            });
                          },
                        )
                            : SizedBox(height: 10),
                        HomeBalanceWidget(darkMode: darkMode, displayBalance: displayBalance,),
                        LinkSectionWidget(darkMode: darkMode,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: darkMode ? TColors.textPrimaryO40 : Colors.white,
                    child: CurrencyWidget()
                  ),
                  const SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.only(top: 10),
                    color: darkMode ? TColors.textPrimaryO40 : Colors.white,
                    child: TabBar(
                        isScrollable: true,
                        indicatorColor: TColors.primary,
                        labelColor: darkMode ? Colors.white : Colors.black,
                        unselectedLabelColor: Colors.grey,
                        dividerColor: darkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                        overlayColor: MaterialStatePropertyAll(Colors.transparent),
                        tabAlignment: TabAlignment.start,
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: TSizes.fontWeightMd,
                            fontFamily: TTexts.fontFamily
                        ),
                        tabs: [
                          Tab(text: 'All Offers',),
                          Tab(text: 'My Offers',),
                          Tab(text: 'My Bids',)
                        ]
                    ),
                  ),
                  Container(
                    color: darkMode ? TColors.textPrimaryO40 : Colors.white,
                    padding: const EdgeInsets.only(bottom: 30.0),
                    height: 400,
                    child: TabBarView(
                        children: [
                          Column(
                            children: [
                              TrendingOffer(
                                offerProvider: offerProvider,
                                darkMode: darkMode,
                                displayOffer: displayOffer,
                              ),
                              if (offerProvider.allOffers.isNotEmpty)
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  // tileColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
                                  onTap: () {
                                    controller.selectedIndex.value = 1;
                                  },
                                  title: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                              color: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1),
                                            )
                                        )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'More',
                                          style: TextStyle(
                                              color: darkMode ? Colors.white : Colors.grey,
                                              fontSize: 14,
                                              fontWeight: TSizes.fontWeightNm
                                          ),),
                                        SizedBox(width: 3),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: darkMode ? Colors.white : Colors.grey,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                          Column(
                            children: [
                              MyOfferScreen(darkMode: darkMode, length: '3', displayMyOffer: displayMyOffer,),
                              if (offerProvider.allOffers.isNotEmpty)
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                // tileColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
                                onTap: () {
                                  Get.to(() => const MyBidAndOfferScreen());
                                },
                                title: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1),
                                      )
                                    )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'More',
                                        style: TextStyle(
                                            color: darkMode ? Colors.white : Colors.grey,
                                            fontSize: 14,
                                            fontWeight: TSizes.fontWeightNm
                                        ),),
                                      SizedBox(width: 3),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: darkMode ? Colors.white : Colors.grey,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              MyBidScreen(darkMode: darkMode, length: '3', displayMyBids: displayMyBid,),
                              if (offerProvider.myBids.isNotEmpty)
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                // tileColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
                                onTap: () {
                                  Get.to(() => const MyBidAndOfferScreen());
                                },
                                title: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                            color: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1),
                                          )
                                      )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'More',
                                        style: TextStyle(
                                            color: darkMode ? Colors.white : Colors.grey,
                                            fontSize: 14,
                                            fontWeight: TSizes.fontWeightNm
                                        ),),
                                      SizedBox(width: 3),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: darkMode ? Colors.white : Colors.grey,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

