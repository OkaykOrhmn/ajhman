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

  const HorizontalListView(
      {super.key,
      required this.items,
       this.height,
      required this.item,
      this.width});

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
            return Container(
              width: widget.width,
              child: widget.items == null
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: DesignConfig.highBorderRadius,
                            color: Colors.white,
                            boxShadow: DesignConfig.lowShadow),
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        width: MediaQuery.sizeOf(context).width,
                        height: 400,
                      ))
                  : widget.item(index),
            );
          }),
    );
  }
}
