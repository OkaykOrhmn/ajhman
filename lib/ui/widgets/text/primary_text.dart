import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/bloc/theme_bloc.dart';

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
          fontSize: style.fontSize! * context.read<ThemeBloc>().state.fontSize),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      softWrap: true,
    );
  }
}
