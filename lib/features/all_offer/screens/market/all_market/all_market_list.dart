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

class AllMarketList extends StatefulWidget {
  const AllMarketList({super.key});

  @override
  State<AllMarketList> createState() => _AllMarketListState();
}

class _AllMarketListState extends State<AllMarketList> {
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
      _toggleLoading(true);
      _fetchOffers();
    } else {
      _toggleLoading(false);
    }
  }

  Future<void> _fetchOffers() async {
    await NoLoaderService.instance.getAllOffers(
      offerProvider: offerProvider,
      onSuccess: () {
        _toggleLoading(false);
        print('pppppppp');
      },
      onFailure: () {
        _toggleLoading(false);
        print('ppppppppjjjjjj');
      },
    );
  }

  void _toggleLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> _refreshAllOffers() async {
    await _fetchOffers();
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return OrderShimmer();
    } else if (offerProvider.allOffers.isEmpty) {
      return const NoOfferScreen();
    } else {
      return CustomRefreshIndicator(
        onRefresh: _refreshAllOffers,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: TListLayout(
            itemCount: offerProvider.allOffers.length,
            itemBuilder: (_, index) {
              final item = offerProvider.allOffers[index];
              return OfferItem(item: item);
            },
          ),
        ),
      );
    }
  }
}
