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

class CadMarketList extends StatefulWidget {
  const CadMarketList({super.key});

  @override
  State<CadMarketList> createState() => _CadMarketListState();
}

class _CadMarketListState extends State<CadMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );
    if (offerProvider.cadOffers.isEmpty) {
      _fetchGbpOffers();
      _toggleLoading(true);
    } else {
      _fetchGbpOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchGbpOffers() async {
    await NoLoaderService.instance.getCadOffers(
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
    } else if (offerProvider.cadOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshGbpOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.cadOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.cadOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
