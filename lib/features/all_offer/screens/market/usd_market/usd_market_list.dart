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

class UsdMarketList extends StatefulWidget {
  const UsdMarketList({super.key});

  @override
  State<UsdMarketList> createState() => _UsdMarketListState();
}

class _UsdMarketListState extends State<UsdMarketList> {
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
      _fetchUsdOffers();
      _toggleLoading(true);
    } else {
      _fetchUsdOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchUsdOffers() async {
    await NoLoaderService.instance.getUsdOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshUsdOffers() async {
    await _fetchUsdOffers();
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
    } else if (offerProvider.usdOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshUsdOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.usdOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.usdOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
