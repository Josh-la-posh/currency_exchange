import 'package:flutter/material.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import 'package:provider/provider.dart';
import '../../../../../data/modules/app_navigator.dart';
import '../../../../../data/modules/background_task.dart';
import '../../../../../data/provider/offer_provider.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../../../utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';

class GbpMarketList extends StatefulWidget {
  const GbpMarketList({super.key});

  @override
  State<GbpMarketList> createState() => _GbpMarketListState();
}

class _GbpMarketListState extends State<GbpMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );
    if (offerProvider.gbpOffers.isEmpty) {
      _fetchGbpOffers();
      _toggleLoading(true);
    } else {
      _fetchGbpOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchGbpOffers() async {
    await NoLoaderService.instance.getGbpOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshGbpOffers() async {
    await _fetchGbpOffers();
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
    } else if (offerProvider.gbpOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshGbpOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.gbpOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.gbpOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
