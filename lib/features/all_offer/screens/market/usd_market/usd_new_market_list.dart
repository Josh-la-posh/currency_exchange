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

class UsdNewMarketList extends StatefulWidget {
  const UsdNewMarketList({
    super.key,
  });

  @override
  State<UsdNewMarketList> createState() => _AllMarketListState();
}

class _AllMarketListState extends State<UsdNewMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );
    if (offerProvider.usdOffers.isEmpty) {
      _fetchUsdNewOffers();
      _toggleLoading(true);
    } else {
      _fetchUsdNewOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchUsdNewOffers() async {
    await NoLoaderService.instance.getUsdNewOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshUsdNewOffers() async {
    await _fetchUsdNewOffers();
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
    } else if (offerProvider.usdNewOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshUsdNewOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.usdNewOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.usdNewOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
