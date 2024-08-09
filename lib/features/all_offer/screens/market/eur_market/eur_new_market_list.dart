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

class EurNewMarketList extends StatefulWidget {
  const EurNewMarketList({
    super.key,
  });

  @override
  State<EurNewMarketList> createState() => _AllMarketListState();
}

class _AllMarketListState extends State<EurNewMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );
    if (offerProvider.eurOffers.isEmpty) {
      _fetchEurNewOffers();
      _toggleLoading(true);
    } else {
      _fetchEurNewOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchEurNewOffers() async {
    await NoLoaderService.instance.getEurNewOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshEurNewOffers() async {
    await _fetchEurNewOffers();
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
    } else if (offerProvider.eurNewOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshEurNewOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.eurNewOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.eurNewOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
