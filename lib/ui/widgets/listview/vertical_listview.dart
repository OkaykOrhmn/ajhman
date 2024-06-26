import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class VerticalListView extends StatefulWidget {
  final List<dynamic>? items;
  final double? width;
  final double? height;
  final ScrollPhysics? physics;
  final Widget Function(BuildContext,int) item;
  final Widget? placeholder;

  const VerticalListView(
      {super.key,
      this.items,
      this.width,
      this.height,
      required this.item,
      this.physics = const NeverScrollableScrollPhysics(), this.placeholder});

  @override
  State<VerticalListView> createState() => _VerticalListViewState();
}

class _VerticalListViewState extends State<VerticalListView> {
  @override
  Widget build(BuildContext context) {
    final length = widget.items == null ? 4 : widget.items!.length;
    widget.placeholder?? const SizedBox();
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ListView.builder(
          physics: widget.physics,
          shrinkWrap: true,
          itemCount: length,
          itemBuilder: (context, index) {
            return widget.items == null
                ? widget.placeholder
                : widget.item(context,index);
          }),
    );
  }
}
