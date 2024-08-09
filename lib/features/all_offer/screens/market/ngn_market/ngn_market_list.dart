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

class NgnMarketList extends StatefulWidget {
  const NgnMarketList({super.key});

  @override
  State<NgnMarketList> createState() => _NgnMarketListState();
}

class _NgnMarketListState extends State<NgnMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false,
    );
    if (offerProvider.ngnOffers.isEmpty) {
      _fetchNgnOffers();
      _toggleLoading(true);
    } else {
      _fetchNgnOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchNgnOffers() async {
    await NoLoaderService.instance.getNgnOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshNgnOffers() async {
    await _fetchNgnOffers();
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
    } else if (offerProvider.ngnOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshNgnOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.ngnOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.ngnOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
