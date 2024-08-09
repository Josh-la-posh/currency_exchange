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

class AllNewMarketList extends StatefulWidget {
  const AllNewMarketList({super.key});

  @override
  State<AllNewMarketList> createState() => _AllNewMarketListState();
}

class _AllNewMarketListState extends State<AllNewMarketList> {
  late OfferProvider offerProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    offerProvider = Provider.of<OfferProvider>(
      AppNavigator.instance.navigatorKey.currentContext!,
      listen: false,
    );
    if (offerProvider.allOffers.isEmpty) {
      _fetchNewOffers();
      _toggleLoading(true);
    } else {
      _fetchNewOffers();
      _toggleLoading(false);
    }
  }

  Future<void> _fetchNewOffers() async {
    await NoLoaderService.instance.getAllNewOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
      },
      onFailure: () {
        _toggleLoading(false);
      },
    );
  }

  void _toggleLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> _refreshAllNewOffers() async {
    await _fetchNewOffers();
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return OrderShimmer();
    } else if (offerProvider.allNewOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshAllNewOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.allNewOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.allNewOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
