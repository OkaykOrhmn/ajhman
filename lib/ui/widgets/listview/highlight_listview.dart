import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0)
                                      .copyWith(top: 6),
                              child: Icon(
                                Icons.circle,
                                size: 8,
                                color: Theme.of(context).editTextFont(),
                              ),
                            ),
                            Expanded(
                              child: PrimaryText(
                                  text: widget.items[index].toString(),
                                  style: Theme.of(context).textTheme.title,
                                  textAlign: TextAlign.start,
                                  color: Theme.of(context).editTextFont()),
                            )
                          ],
                        ),
                ),
              );
            }));
  }
}
