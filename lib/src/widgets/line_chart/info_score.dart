// Cores
import 'package:flutter/material.dart';
// Models
import 'package:supreme_chart/src/models/line_chart.dart';
// Utils
import 'package:supreme_chart/src/utils/constants/colors/colors.dart';

class InfoScore extends StatelessWidget {
  final LineChart month;
  final String textScore;
  final double chartWidth;
  final double scoreContentWidth;
  final double scoreContentHeight;
  final double scoreArrowWidth;
  final double scoreArrowHeight;
  final Color colorBgInfo;
  final Color colorTextInfo;

  InfoScore({
    Key key,
    this.month,
    this.textScore,
    this.chartWidth,
    this.scoreContentWidth = 50,
    this.scoreContentHeight = 50,
    this.scoreArrowHeight = 10,
    this.scoreArrowWidth = 15,
    this.colorBgInfo = ThemeColors.mainColor,
    this.colorTextInfo = ThemeColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLeft = month.offset.dx < chartWidth * 2 / 3;
    return Row(
      children: <Widget>[
        if (_isLeft)
          ClipPath(
            clipper: CustomInfoScoreMarker(isShowLeft: true),
            child: Container(
              width: scoreArrowWidth,
              height: scoreArrowHeight,
              color: colorBgInfo,
            ),
          ),
        Transform.translate(
          offset: Offset(_isLeft ? -1 : 1, 0),
          child: Container(
            width: scoreContentWidth,
            height: scoreContentHeight,
            decoration: BoxDecoration(
              color: colorBgInfo,
              borderRadius: BorderRadius.circular(3),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  textScore,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorTextInfo,
                  ),
                ),
                Text(
                  '${month.value}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: colorTextInfo,
                  ),
                )
              ],
            ),
          ),
        ),
        if (!_isLeft)
          ClipPath(
            clipper: CustomInfoScoreMarker(isShowLeft: false),
            child: Container(
              width: scoreArrowWidth,
              height: scoreArrowHeight,
              color: colorBgInfo,
            ),
          ),
      ],
    );
  }
}

class CustomInfoScoreMarker extends CustomClipper<Path> {
  final bool isShowLeft;

  CustomInfoScoreMarker({this.isShowLeft});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (isShowLeft) {
      path
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, 0);
    } else {
      path..lineTo(size.width, 0)..lineTo(0, size.height)..lineTo(0, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(CustomInfoScoreMarker oldClipper) => false;
}
