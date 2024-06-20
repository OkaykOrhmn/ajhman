import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: PrimaryText(text: "چیزی در این صفحه وجود ندارد", style: Theme.of(context).textTheme.headerBold, color: Theme.of(context).pinTextFont())
    );
  }
}
