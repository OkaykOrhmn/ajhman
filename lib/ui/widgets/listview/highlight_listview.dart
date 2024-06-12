import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../text/primary_text.dart';

class HighlightListView extends StatefulWidget {
  final List<String> items;
  final double? width;
  final double? height;

  const HighlightListView(
      {super.key, required this.items, this.height, this.width});

  @override
  State<HighlightListView> createState() => _HighlightListViewState();
}

class _HighlightListViewState extends State<HighlightListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: widget.height,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Center(
                  child: widget.items.isEmpty
                      ? const SizedBox()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Padding(
                              padding:  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 6),
                              child:  const Icon(
                                Icons.circle,
                                size: 8,
                                color: grayColor600,
                              ),
                            ),
                            Expanded(
                              child: PrimaryText(
                                  text: widget.items[index].toString(),
                                  style: mThemeData.textTheme.title,
                                  textAlign: TextAlign.start,
                                  color: grayColor600),
                            )
                          ],
                        ),
                ),
              );
            }));
  }
}
