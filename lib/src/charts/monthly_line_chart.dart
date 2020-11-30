// Cores
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
// Models
import 'package:supreme_chart/src/models/line_chart.dart';
// Widgets
import 'package:supreme_chart/src/widgets/line_chart/action_chart.dart';
import 'package:supreme_chart/src/widgets/line_chart/draw_chart.dart';
import 'package:supreme_chart/src/widgets/line_chart/info_score.dart';
import 'package:supreme_chart/src/widgets/line_chart/column_vertical_measure.dart';
// Utils
import 'package:supreme_chart/src/utils/constants/colors/colors.dart';
import 'package:supreme_chart/src/utils/constants/strings/index.dart'
    as strings;

enum MonthEnum {
  midyear,
  yearling,
}

class MonthlyLineChart extends StatefulWidget {
  final MonthEnum typeMonth;
  final double maxAmplitude;
  final List<int> levelAmplitude;
  final int activeMonth;
  final double chartWidth;
  final double chartHeight;
  final double horizontalPadding;
  final double lineWidth;
  final double strokeWidth;
  final double circularSize;
  final double scoreContentWidth;
  final double scoreContentHeight;
  final double scoreArrowWidth;
  final double scoreArrowHeight;
  final double buttonCircleSize;
  final String textScoreDescription;
  final List<Color> colorGradientShadow;
  final Color colorBgActiveAction;
  final Color colorBgTextActiveAction;
  final Color colorDrawLine;
  final Color colorBgInfo;
  final Color colorTextInfo;
  final Color colorLineVerticalMeasure;
  final Color colorBoderIndicatorMeasure;

  MonthlyLineChart({
    this.typeMonth = MonthEnum.yearling,
    this.maxAmplitude = 100,
    @required this.levelAmplitude,
    this.activeMonth,
    this.chartWidth,
    this.chartHeight = 145,
    this.horizontalPadding = 16,
    this.lineWidth = 3,
    this.strokeWidth = 2,
    this.circularSize = 10,
    this.scoreContentWidth = 50,
    this.scoreContentHeight = 50,
    this.scoreArrowWidth = 15,
    this.scoreArrowHeight = 10,
    this.buttonCircleSize = 30,
    this.textScoreDescription = strings.score,
    this.colorGradientShadow = const [
      ThemeColors.aliceBlue,
      ThemeColors.white,
    ],
    this.colorBgActiveAction = ThemeColors.mainColor,
    this.colorBgTextActiveAction = ThemeColors.blueBlackOpacity055,
    this.colorDrawLine = ThemeColors.mainColor,
    this.colorBgInfo = ThemeColors.mainColor,
    this.colorTextInfo = ThemeColors.white,
    this.colorLineVerticalMeasure = ThemeColors.blueBlackOpacity05,
    this.colorBoderIndicatorMeasure = ThemeColors.mainColor,
  });

  @override
  _MonthlyLineChartState createState() => _MonthlyLineChartState();
}

class _MonthlyLineChartState extends State<MonthlyLineChart> {
  List<LineChart> _months = [];
  LineChart _monthActive;
  double _chartWidth;
  int _numberItems;

  @override
  void initState() {
    super.initState();
    _initMonthValue();
    _addItemMonthChart();
  }

  void _initLayoutChart() {
    _chartWidth = (widget.chartWidth ?? MediaQuery.of(context).size.width) -
        (widget.horizontalPadding * 2);
  }

  void _initMonthValue() {
    _numberItems = widget.typeMonth == MonthEnum.yearling ? 12 : 6;
    _monthActive = null;
    for (var i = 1; i <= _numberItems; i++) {
      _months.add(
        LineChart(
          text: i.toString(),
          isActive: false,
          value: null,
        ),
      );
    }
  }

  void _addItemMonthChart() {
    widget.levelAmplitude.asMap().forEach((index, value) {
      if (index <= _months.length - 1) {
        if (widget.activeMonth == index + 1) {
          _monthActive = _months[index];
          _months[index].isActive = true;
        }
        _months[index].value = value;
      }
    });
    Timer(
      Duration(milliseconds: 500),
      () => setState(() {}),
    );
  }

  void _updateItemActive(LineChart item) {
    _months.forEach((element) {
      if (element.text == item.text) {
        element.isActive = true;
        _monthActive = item;
      } else {
        element.isActive = false;
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _initLayoutChart();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  _renderShadowChart(),
                  _wrapChart(),
                  if (_monthActive?.offset?.dx != null) _infoScore()
                ],
              ),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _months
                    .map(
                      (e) => ActionChart(
                        itemPositionSize: _chartWidth / _numberItems,
                        monthData: e,
                        updateItemActive: _updateItemActive,
                        buttonCircleSize: widget.buttonCircleSize,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _wrapChart() {
    return CustomPaint(
      painter: DrawChart(
        months: _months,
        maxAmplitude: widget.maxAmplitude,
        circularSize: widget.circularSize,
        totalItems: _numberItems,
        strokeWidth: widget.strokeWidth,
        lineWidth: widget.lineWidth,
        lineColor: widget.colorDrawLine,
        paintingStyle: PaintingStyle.stroke,
      ),
      size: Size(double.infinity, widget.chartHeight),
      child: _drawColumnMeasure(),
    );
  }

  Widget _infoScore() {
    return Positioned(
      top: _monthActive.offset.dy -
          ((widget.scoreContentHeight - widget.scoreArrowHeight) / 2),
      left: _monthActive.offset.dx < _chartWidth * 2 / 3
          ? _monthActive.offset.dx + 10
          : _monthActive.offset.dx -
              widget.scoreContentWidth -
              widget.scoreArrowWidth -
              10,
      child: InfoScore(
        month: _monthActive,
        chartWidth: _chartWidth,
        scoreContentHeight: widget.scoreContentHeight,
        scoreContentWidth: widget.scoreContentWidth,
        scoreArrowHeight: widget.scoreArrowHeight,
        scoreArrowWidth: widget.scoreArrowWidth,
        textScore: widget.textScoreDescription,
        colorBgInfo: widget.colorBgInfo,
        colorTextInfo: widget.colorTextInfo,
      ),
    );
  }

  Widget _renderShadowChart() {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: CustomPaint(
        size: Size.infinite,
        painter: DrawChart(
          months: _months,
          maxAmplitude: widget.maxAmplitude,
          circularSize: widget.circularSize,
          totalItems: _numberItems,
          strokeWidth: 0,
          lineWidth: 0,
          paintingStyle: PaintingStyle.fill,
          colors: widget.colorGradientShadow,
        ),
      ),
    );
  }

  Widget _drawColumnMeasure() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _months
            .map(
              (e) => ColumnVerticalMeasure(
                month: e,
                itemHeight: widget.chartHeight,
                strokeWidth: widget.strokeWidth,
                maxAmplitude: widget.maxAmplitude,
                circularSize: widget.circularSize,
                itemWidth: _chartWidth / _numberItems,
                colorLineVerticalMeasure: widget.colorLineVerticalMeasure,
                colorBoderIndicatorMeasure: widget.colorBoderIndicatorMeasure,
              ),
            )
            .toList(),
      ),
    );
  }
}
