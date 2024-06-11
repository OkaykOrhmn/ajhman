import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/widget/design_config.dart';

class HorizontalListView extends StatefulWidget {
  final List<dynamic>? items;
  final double? width;
  final double? height;
  final dynamic Function(int) item;
  final dynamic Function(int)? placeholder;

  const HorizontalListView(
      {super.key,
      required this.items,
       this.height,
      required this.item,
      this.width, this.placeholder});

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  @override
  Widget build(BuildContext context) {
    final length = widget.items == null ? 4 : widget.items!.length;
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: widget.height,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: widget.width,
              child: widget.items == null
                  ? widget.placeholder != null? widget.placeholder!(index) : const SizedBox()
                  : widget.item(index),
            );
          }),
    );
  }
}
