import 'package:flutter/cupertino.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;

  const PrimaryText(
      {super.key,
      required this.text,
      required this.style,
      required this.color,
      this.textAlign = TextAlign.center,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: color,
      ),
      textAlign: textAlign,
      maxLines:
          maxLines,
      overflow: maxLines == null?TextOverflow.visible: TextOverflow.ellipsis,
      softWrap: false,
    );
  }
}
