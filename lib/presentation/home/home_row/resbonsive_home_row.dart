import 'package:flutter/material.dart';
import 'package:younmin/presentation/home/home_row/home_row.dart';
import 'package:younmin/presentation/home/home_row/home_row_mobile.dart';

class ResponsiveHomeRow extends StatelessWidget {
  const ResponsiveHomeRow({
    Key? key,
    required this.alignFromStart,
    required this.mainText,
    required this.subText,
    required this.imageAsset,
    required this.mainTextSize,
    required this.mainTextConstraint,
    required this.subTextConstraint,
    this.subscribe = false,
  }) : super(key: key);

  final bool alignFromStart;
  final String mainText;
  final String subText;
  final AssetImage imageAsset;
  final double mainTextSize;
  final double mainTextConstraint;
  final double subTextConstraint;
  final bool subscribe;
  @override
  Widget build(BuildContext context) {
    // return a the subscribe widget if asked
    // it's a little helpful to use with a listBuilder
    if (MediaQuery.of(context).size.width < 1200) {
      return HomeRowMobile(
        alignFromStart: alignFromStart,
        mainText: mainText,
        subText: subText,
        imageAsset: imageAsset,
        mainTextSize: mainTextSize,
        mainTextConstraint: mainTextConstraint,
        subTextConstraint: subTextConstraint,
      );
    } else {
      return HomeRow(
        alignFromStart: alignFromStart,
        mainText: mainText,
        subText: subText,
        imageAsset: imageAsset,
        mainTextSize: mainTextSize,
        mainTextConstraint: mainTextConstraint,
        subTextConstraint: subTextConstraint,
      );
    }
  }
}
