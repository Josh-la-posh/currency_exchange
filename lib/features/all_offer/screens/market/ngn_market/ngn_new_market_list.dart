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

class NgnNewMarketList extends StatefulWidget {
  const NgnNewMarketList({
    super.key,
  });

  @override
  State<NgnNewMarketList> createState() => _AllMarketListState();
}

class _AllMarketListState extends State<NgnNewMarketList> {
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
      _fetchNgnNewOffers();
      _toggleLoading(true);
    } else {
      _fetchNgnNewOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchNgnNewOffers() async {
    await NoLoaderService.instance.getNgnNewOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  Future<void> _refreshNgnNewOffers() async {
    await _fetchNgnNewOffers();
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
    } else if (offerProvider.ngnNewOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshNgnNewOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.ngnNewOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.ngnNewOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
