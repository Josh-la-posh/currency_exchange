import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/sizes.dart';

class OrderShimmer extends StatelessWidget {
  String? length;
  OrderShimmer({super.key, this.length});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2),
      child: ListView.builder(
          itemCount: length != null ? int.parse(length!) : 10,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: TSizes.textReviewHeight * 1.4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 12.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                        ),
                        Container(
                          width: 40,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 12.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                        ),
                        Container(
                          width: 40,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

      ),
    );
  }
}
