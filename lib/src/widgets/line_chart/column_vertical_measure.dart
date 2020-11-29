// Cores
import 'package:flutter/material.dart';
// Models
import 'package:supreme_chart/src/models/line_chart.dart';
// Utils
import 'package:supreme_chart/src/utils/constants/colors/colors.dart';

class ColumnVerticalMeasure extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;
  final double strokeWidth;
  final double maxAmplitude;
  final double circularSize;
  final LineChart month;
  final Color colorLineVerticalMeasure;
  final Color colorBoderIndicatorMeasure;

  ColumnVerticalMeasure({
    Key key,
    this.itemHeight,
    this.strokeWidth,
    this.maxAmplitude,
    this.circularSize,
    this.itemWidth,
    this.month,
    this.colorLineVerticalMeasure = ThemeColors.blueBlackOpacity05,
    this.colorBoderIndicatorMeasure = ThemeColors.mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: itemHeight + circularSize / 2 + strokeWidth,
          width: itemWidth,
          alignment: Alignment.bottomCenter,
          child: Container(
            height: itemHeight,
            width: 1,
            color: colorLineVerticalMeasure,
          ),
        ),
        if (month.value != null)
          Positioned(
            bottom: month.value * itemHeight / maxAmplitude - circularSize / 2,
            left: (itemWidth - circularSize) / 2,
            child: month.isActive
                ? Container(
                    width: circularSize,
                    height: circularSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: CircularProgressIndicator(
                      value: 100,
                      strokeWidth: strokeWidth,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorBoderIndicatorMeasure,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
      ],
    );
  }
}
