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

class NgnTrendingMarketList extends StatefulWidget {
  const NgnTrendingMarketList({super.key});

  @override
  State<NgnTrendingMarketList> createState() => _NgnTrendingMarketListState();
}

class _NgnTrendingMarketListState extends State<NgnTrendingMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );
    if (offerProvider.ngnTrendingOffers.isEmpty) {
      _fetchNgnTrendingOffers();
      _toggleLoading(true);
    } else {
      _fetchNgnTrendingOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchNgnTrendingOffers() async {
    await NoLoaderService.instance.getNgnTrendingOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshNgnTrendingOffers() async {
    await _fetchNgnTrendingOffers();
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
    } else if (offerProvider.ngnTrendingOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshNgnTrendingOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.ngnTrendingOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.ngnTrendingOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
