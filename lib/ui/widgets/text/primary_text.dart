import 'package:flutter/cupertino.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;

  const PrimaryText({super.key, required this.text, required this.style, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}
