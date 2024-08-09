import 'package:get/get.dart';
import 'package:pouch/features/all_offer/models/offer.dart';
import 'package:pouch/features/all_offer/screens/market/all_market/all_market_list.dart';
import 'package:pouch/features/all_offer/screens/market/all_market/all_new_market_list.dart';
import 'package:pouch/features/all_offer/screens/market/all_market/all_trending_market_list.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/data/modules/background_task.dart';

class AllMarketController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final RxBool showAllOffer = false.obs;
  final RxBool showAllTrendingOffer = false.obs;
  final RxList<OfferEntity> allTrendingOffers = <OfferEntity>[].obs;

  final OfferProvider offerProvider;

  AllMarketController({required this.offerProvider});

  final screens = [
    const AllMarketList(),
    const AllNewMarketList(),
    const AllTrendingMarketList(),
  ];

  @override
  void onInit() {
    super.onInit();
    _fetchOffers();
    _fetchAllNewOffers();
    _fetchAllTrendingOffers();
  }

  Future<void> _fetchOffers() async {
    showAllOffer(false);
    if (offerProvider.allOffers.isEmpty) {
      await NoLoaderService.instance.getAllOffers(
        offerProvider: offerProvider,
        onSuccess: () => showAllOffer(true),
        onFailure: () => showAllOffer(true),
      );
    } else {
      showAllOffer(true);
    }
  }

  Future<void> _fetchAllNewOffers() async {
    showAllOffer(false);
    if (offerProvider.allNewOffers.isEmpty) {
      await NoLoaderService.instance.getAllNewOffers(
        offerProvider: offerProvider,
        onSuccess: () => showAllOffer(true),
        onFailure: () => showAllOffer(true),
      );
    } else {
      showAllOffer(true);
    }
  }

  Future<void> _fetchAllTrendingOffers() async {
    showAllTrendingOffer(false);
    if (allTrendingOffers.isEmpty) {
      try {
        var fetchedItems = await NoLoaderService.instance.getAllTrendingOffers(
          offerProvider: offerProvider,
          onSuccess: () {

          },
          onFailure: () {},
        );
        print('all the game ${fetchedItems.length}');
        allTrendingOffers.value = fetchedItems;
      } finally {
        showAllTrendingOffer(true);
      }
    } else {
      showAllTrendingOffer(true);
    }
  }

  Future<void> refreshAllOffers(String type) async {
    await _fetchOffers();
  }

  Future<void> refreshAllTrendingOffers() async {
    await _fetchAllTrendingOffers();
  }
}
