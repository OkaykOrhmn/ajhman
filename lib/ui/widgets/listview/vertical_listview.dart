import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/widget/design_config.dart';

class VerticalListView extends StatefulWidget {
  final List<dynamic>? items;
  final double? width;
  final double? height;
  final ScrollPhysics? physics;
  final Widget Function(BuildContext,int) item;

  const VerticalListView(
      {super.key,
      this.items,
      this.width,
      this.height,
      required this.item,
      this.physics = const NeverScrollableScrollPhysics()});

  @override
  State<VerticalListView> createState() => _VerticalListViewState();
}

class _VerticalListViewState extends State<VerticalListView> {
  @override
  Widget build(BuildContext context) {
    final length = widget.items == null ? 4 : widget.items!.length;
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ListView.builder(
          physics: widget.physics,
          shrinkWrap: true,
          itemCount: length,
          itemBuilder: (context, index) {
            return widget.items == null
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
                      height: 175,
                    ))
                : widget.item(context,index);
          }),
    );
  }
}
