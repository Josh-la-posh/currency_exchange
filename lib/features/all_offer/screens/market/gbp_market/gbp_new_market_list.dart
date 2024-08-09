import 'package:flutter/material.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/utils/shimmer/order_shimmer.dart';
import 'package:provider/provider.dart';
import '../../../../../data/modules/app_navigator.dart';
import '../../../../../data/provider/offer_provider.dart';
import '../../../../../utils/layouts/list_layout.dart';
import '../../../../../utils/shared/refresh_indicator/refresh_indicator.dart';
import '../../../widgets/no_offer.dart';
import '../../../widgets/offer_item.dart';

class GbpNewMarketList extends StatefulWidget {
  const GbpNewMarketList({
    super.key,
  });

  @override
  State<GbpNewMarketList> createState() => _AllMarketListState();
}

class _AllMarketListState extends State<GbpNewMarketList> {
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
      _fetchGbpNewOffers();
      _toggleLoading(true);
    } else {
      _fetchGbpNewOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchGbpNewOffers() async {
    await NoLoaderService.instance.getGbpNewOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshGbpNewOffers() async {
    await _fetchGbpNewOffers();
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
    } else if (offerProvider.gbpNewOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshGbpNewOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.gbpNewOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.gbpNewOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
