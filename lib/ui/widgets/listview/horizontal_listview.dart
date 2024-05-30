import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/widget/design_config.dart';

class HorizontalListView extends StatefulWidget {
  final List<dynamic>? items;
  final double? width;
  final double height;
  final dynamic Function(int) item;

  const HorizontalListView(
      {super.key,
      required this.items,
      required this.height,
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
      child: DefaultPlaceHolder(
        widget: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (context, index) {
              return Padding(
                padding: DesignConfig.horizontalListViwItemPadding(16, index, length),
                child: Center(
                  child: Container(
                      width: widget.width,
                      // constraints: BoxConstraints(
                      //     minWidth: 100, maxWidth: 350),
                      decoration: BoxDecoration(
                          borderRadius: DesignConfig.highBorderRadius,
                          boxShadow: DesignConfig.defaultShadow,
                          color: Colors.white),
                      padding: const EdgeInsets.all(8),
                      child: widget.items == null
                          ? SizedBox(
                              width: widget.width,
                              height: widget.height,
                            )
                          : widget.item(index)),
                ),
              );
            }),
        isLoading: widget.items == null,
      ),
    );
  }
}
