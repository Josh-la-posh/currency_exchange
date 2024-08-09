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

class GbpTrendingMarketList extends StatefulWidget {
  const GbpTrendingMarketList({super.key});

  @override
  State<GbpTrendingMarketList> createState() => _GbpTrendingMarketListState();
}

class _GbpTrendingMarketListState extends State<GbpTrendingMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );
    if (offerProvider.gbpTrendingOffers.isEmpty) {
      _fetchGbpTrendingOffers();
      _toggleLoading(true);
    } else {
      _fetchGbpTrendingOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchGbpTrendingOffers() async {
    await NoLoaderService.instance.getGbpTrendingOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshGbpTrendingOffers() async {
    await _fetchGbpTrendingOffers();
    await Future.delayed(const Duration(seconds: 2));
  }

  void _toggleLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return OrderShimmer();
    } else if (offerProvider.gbpTrendingOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshGbpTrendingOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.gbpTrendingOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.gbpTrendingOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
