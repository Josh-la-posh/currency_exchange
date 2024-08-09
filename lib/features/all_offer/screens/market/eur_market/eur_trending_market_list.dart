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

class EurTrendingMarketList extends StatefulWidget {
  const EurTrendingMarketList({super.key});

  @override
  State<EurTrendingMarketList> createState() => _EurTrendingMarketListState();
}

class _EurTrendingMarketListState extends State<EurTrendingMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );
    if (offerProvider.eurTrendingOffers.isEmpty) {
      _fetchEurTrendingOffers();
      _toggleLoading(true);
    } else {
      _fetchEurTrendingOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchEurTrendingOffers() async {
    await NoLoaderService.instance.getEurTrendingOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshEurTrendingOffers() async {
    await _fetchEurTrendingOffers();
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
    } else if (offerProvider.eurTrendingOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshEurTrendingOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.eurTrendingOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.eurTrendingOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
