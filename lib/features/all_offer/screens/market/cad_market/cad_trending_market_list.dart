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

class CadTrendingMarketList extends StatefulWidget {
  const CadTrendingMarketList({super.key});

  @override
  State<CadTrendingMarketList> createState() => _CadTrendingMarketListState();
}

class _CadTrendingMarketListState extends State<CadTrendingMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );
    if (offerProvider.cadTrendingOffers.isEmpty) {
      _fetchCadTrendingOffers();
      _toggleLoading(true);
    } else {
      _fetchCadTrendingOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchCadTrendingOffers() async {
    await NoLoaderService.instance.getCadTrendingOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshCadTrendingOffers() async {
    await _fetchCadTrendingOffers();
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
    } else if (offerProvider.cadTrendingOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshCadTrendingOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.cadTrendingOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.cadTrendingOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
