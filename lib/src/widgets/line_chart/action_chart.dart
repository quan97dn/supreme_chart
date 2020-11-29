// Cores
import 'package:flutter/material.dart';
// Models
import 'package:supreme_chart/src/models/line_chart.dart';
// Utils
import 'package:supreme_chart/src/utils/constants/colors/colors.dart';

class ActionChart extends StatelessWidget {
  final double itemPositionSize;
  final double buttonCircleSize;
  final LineChart monthData;
  final Function(LineChart chart) updateItemActive;
  final Color colorBgActive;
  final Color colorBgTextActive;

  const ActionChart({
    Key key,
    this.itemPositionSize,
    this.buttonCircleSize = 30,
    this.monthData,
    this.updateItemActive,
    this.colorBgActive = ThemeColors.mainColor,
    this.colorBgTextActive = ThemeColors.blueBlackOpacity055,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: monthData.value != null
          ? () {
              updateItemActive(monthData);
            }
          : null,
      child: Container(
        width: itemPositionSize,
        height: itemPositionSize,
        child: Center(
          child: Container(
            width: buttonCircleSize,
            height: buttonCircleSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(monthData.isActive ? 50 : 0),
              color: monthData.isActive ? colorBgActive : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(
              monthData.text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color:
                    monthData.isActive ? ThemeColors.white : colorBgTextActive,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
