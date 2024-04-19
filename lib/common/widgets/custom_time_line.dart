import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';


class MyTimeLine extends StatelessWidget {
  MyTimeLine({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isDone,
    required this.startChild,
    required this.endChild
  });

  bool isFirst;
  bool isLast;
  bool isDone;
  Widget startChild;
  Widget endChild;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(lineXY: 0.17,
      alignment: TimelineAlign.manual,
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
          color: TColors.textPrimaryO80,
          thickness: 2
      ),
      // afterLineStyle: LineStyle(color: TColors.textPrimaryO80,),
      indicatorStyle: IndicatorStyle(
        // drawGap: true,
        indicatorXY: 0,
        color: isDone ? TColors.textPrimaryO80 : TColors.timeLineBorder,
        width: 12,
        height: 12,
        indicator: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: isDone ? TColors.textPrimaryO80 : TColors.timeLineBorder,
                ),
                borderRadius: BorderRadius.circular(30)
            ),
          ),
        padding: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 0),
      ),
      startChild: startChild,
      endChild: Container(
          margin: const EdgeInsets.only(left: 10),
          child: endChild),
    );
  }
}
