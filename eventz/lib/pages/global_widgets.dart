import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double fontSize;
  final Color color;
  final String fontFamily;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final List<Shadow> shadows;
  final int maxLines;
  final TextOverflow overflow;
  const TitleText(this.text,
      {Key key,
      this.style,
      this.fontSize,
      this.color,
      this.fontFamily,
      this.fontWeight,
      this.textAlign,
      this.shadows,
      this.maxLines,
      this.overflow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.clip,
      style: style ??
          TextStyle(
            fontSize: fontSize ?? 22,
            fontWeight: fontWeight ?? FontWeight.bold,
            fontFamily: fontFamily,
            color: color,
            shadows: shadows,
          ),
    );
  }
}

class SubtitleText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double fontSize;
  final Color color;
  final String fontFamily;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final List<Shadow> shadows;
  final int maxLines;
  final TextOverflow overflow;

  const SubtitleText(this.text,
      {Key key,
      this.style,
      this.fontSize,
      this.color,
      this.fontFamily,
      this.fontWeight,
      this.textAlign,
      this.shadows,
      this.maxLines,
      this.overflow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.clip,
      style: style ??
          TextStyle(
              fontSize: fontSize ?? 18,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontFamily: fontFamily,
              color: color,
              shadows: shadows),
    );
  }
}

// Text titleText(String text,
//     {TextStyle style,
//     double fontSize,
//     Color color,
//     String fontFamily,
//     FontWeight fontWeight}) {
//   return Text(
//     text,
//     style: style ??
//         TextStyle(
//           fontSize: fontSize ?? 25,
//           fontWeight: fontWeight ?? FontWeight.bold,
//           fontFamily: fontFamily,
//           color: color,
//         ),
//   );
// }
