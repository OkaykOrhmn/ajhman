import 'package:ajhman/ui/theme/bloc/theme_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverflowProofText extends StatelessWidget {
  const OverflowProofText(
      {super.key, required this.text, required this.fallback});

  final Text text;
  final Widget fallback;

  @override
  Widget build(BuildContext context) {
    final style = text.style ?? DefaultTextStyle.of(context).style;
    return SizedBox(
        width: double.infinity,
        child:
            LayoutBuilder(builder: (BuildContext context, BoxConstraints size) {
          final TextPainter painter = TextPainter(
            maxLines: 1,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            text: TextSpan(
                style: style.copyWith(
                    fontSize: style.fontSize! *
                        context.read<ThemeBloc>().state.fontSize),
                text: text.data),
          );

          painter.layout(maxWidth: size.maxWidth);

          return painter.didExceedMaxLines ? fallback : text;
        }));
  }
}
