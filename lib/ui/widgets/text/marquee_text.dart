import 'package:ajhman/ui/widgets/text/overflow_proof_text.dart';
import 'package:flutter/widgets.dart';
import 'package:marquee/marquee.dart';

class MarqueeText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final String? marqueeText;
  final TextStyle? marqueeStyle;
  final Duration stop;
  final TextDirection textDirection;
  const MarqueeText(
      {super.key,
      required this.text,
      required this.style,
      this.marqueeText,
      this.marqueeStyle,
      this.stop = Duration.zero,
      this.textDirection = TextDirection.ltr});

  @override
  Widget build(BuildContext context) {
    return OverflowProofText(
        text: Text(
          text,
          style: style,
          maxLines: 1,
        ),
        fallback: SizedBox(
          height: (marqueeStyle == null
                  ? style.fontSize!
                  : marqueeStyle!.fontSize!) *
              DefaultTextStyle.of(context).style.height!,
          child: Center(
            child: Marquee(
              text: marqueeText ?? text,
              scrollAxis: Axis.horizontal,
              textDirection: textDirection,
              crossAxisAlignment: CrossAxisAlignment.center,
              accelerationCurve: Curves.easeOut,
              velocity: 30,
              blankSpace: 34.0,
              accelerationDuration: stop,
              style: marqueeStyle ?? style,
            ),
          ),
        ));
  }
}
