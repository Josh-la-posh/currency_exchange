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

class CadNewMarketList extends StatefulWidget {
  const CadNewMarketList({
    super.key,
  });

  @override
  State<CadNewMarketList> createState() => _AllMarketListState();
}

class _AllMarketListState extends State<CadNewMarketList> {
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
      _fetchCadNewOffers();
      _toggleLoading(true);
    } else {
      _fetchCadNewOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchCadNewOffers() async {
    await NoLoaderService.instance.getCadNewOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshCadNewOffers() async {
    await _fetchCadNewOffers();
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
    } else if (offerProvider.cadNewOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshCadNewOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.cadNewOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.cadNewOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
