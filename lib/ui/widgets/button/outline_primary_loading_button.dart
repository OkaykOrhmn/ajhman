// ignore_for_file: camel_case_types

import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_btn/loading_btn.dart';

class OutlinePrimaryLoadingButton extends StatefulWidget {
  final double width;
  final String title;
  final bool disable;
  final Function(
      Function startLoading, Function stopLoading, ButtonState btnState) onTap;

  const OutlinePrimaryLoadingButton(
      {super.key,
      this.width = double.infinity,
      required this.onTap,
      required this.title,
      required this.disable});

  @override
  State<OutlinePrimaryLoadingButton> createState() =>
      _outlinePrimaryLoadingButtonState();
}

class _outlinePrimaryLoadingButtonState
    extends State<OutlinePrimaryLoadingButton> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingBtn(
      height: 46,
      borderRadius: 14,
      animate: false,
      color: widget.disable
          ? Theme.of(context).disable()
          : Theme.of(context).white(),
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
      width: widget.width,
      elevation: widget.disable ? 0 : 2,
      roundLoadingShape: false,
      disabledColor: Theme.of(context).primaryColor.withOpacity(0.1),
      loader: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: SpinKitThreeBounce(
          color: Theme.of(context).primaryColor,
          size: 36,
          controller: animationController,
        )),
      ),
      onTap: widget.onTap,
      child: PrimaryText(
        text: widget.title,
        style: Theme.of(context).textTheme.title,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
