import 'package:flutter/material.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:provider/provider.dart';
import '../../../../../data/modules/app_navigator.dart';
import '../../../../../data/provider/offer_provider.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';

class AllTrendingMarketList extends StatefulWidget {
  const AllTrendingMarketList({super.key});

  @override
  State<AllTrendingMarketList> createState() => _AllTrendingMarketListState();
}

class _AllTrendingMarketListState extends State<AllTrendingMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext!,
      listen: false,
    );
    if (offerProvider.allTrendingOffers.isEmpty) {
      _toggleLoading(true);
      _fetchTrendingOffers();
    } else {
      _toggleLoading(false);
    }
  }

  Future<void> _fetchTrendingOffers() async {
    await NoLoaderService.instance.getAllTrendingOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  void _toggleLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> _refreshTrendingOffers() async {
    await _fetchTrendingOffers();
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return OrderShimmer();
    } else if (offerProvider.allTrendingOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshTrendingOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.allTrendingOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.allTrendingOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
