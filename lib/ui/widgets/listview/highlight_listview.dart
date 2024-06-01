import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/widget/design_config.dart';

class HighlightListView extends StatefulWidget {
  final List<dynamic>? items;
  final double? width;
  final double? height;
  final dynamic Function(int) item;

  const HighlightListView(
      {super.key,
      required this.items,
      this.height,
      required this.item,
      this.width});

  @override
  State<HighlightListView> createState() => _HighlightListViewState();
}

class _HighlightListViewState extends State<HighlightListView> {
  @override
  Widget build(BuildContext context) {
    final length = widget.items == null ? 4 : widget.items!.length;
    return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: widget.height,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Center(
                  child: widget.items == null
                      ? SizedBox(
                          width: widget.width,
                          height: widget.height,
                        )
                      : widget.item(index),
                ),
              );
            }));
  }
}
