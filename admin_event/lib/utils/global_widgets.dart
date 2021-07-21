import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? fontSize;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final List<Shadow>? shadows;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  const TitleText(this.text,
      {Key? key,
      this.style,
      this.fontSize,
      this.color,
      this.fontFamily,
      this.fontWeight,
      this.textAlign,
      this.shadows,
      this.maxLines,
      this.overflow,
      this.decoration})
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
            decoration: decoration,
            fontSize: fontSize ?? 20,
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
  final TextStyle? style;
  final double? fontSize;
  final FontStyle? fontStyle;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final List<Shadow>? shadows;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  const SubtitleText(this.text,
      {Key? key,
      this.style,
      this.fontSize,
      this.color,
      this.fontFamily,
      this.fontWeight,
      this.textAlign,
      this.shadows,
      this.maxLines,
      this.overflow,
      this.decoration,
      this.fontStyle})
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
              fontStyle: fontStyle,
              decoration: decoration,
              fontSize: fontSize ?? 16,
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

class InfoTile extends StatefulWidget {
  final BoxDecoration? decoration;
  final Widget title, subtitle, image;
  final int flexText, flexImage;
  final Widget? overflowWidget;
  final double? containerHeight;

  const InfoTile(
      {Key? key,
      this.decoration,
      required this.title,
      required this.subtitle,
      required this.image,
      this.flexText = 2,
      this.flexImage = 3,
      this.overflowWidget,
      this.containerHeight = 150.0})
      : super(key: key);
  @override
  _InfoTileState createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.containerHeight! + 50.0,
      child: Stack(
        children: [
          Container(
            height: widget.containerHeight,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Row(
              children: [
                Expanded(
                  flex: widget.flexText,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.title,
                        widget.subtitle,
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: widget.flexImage,
                  child: widget.image,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: widget.overflowWidget ?? SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}

void showSnackBar(context, Widget title,
    {String? actionLabel, VoidCallback? onActionPressed}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      width: 300,
      content: title,
      action: SnackBarAction(
        label: actionLabel ?? 'Done',
        onPressed: onActionPressed ?? () {},
      )));
}

bool isMobile(context) {
  return MediaQuery.of(context).size.width < 800 ? true : false;
}
