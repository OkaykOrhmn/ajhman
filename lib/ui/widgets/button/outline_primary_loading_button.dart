import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/loading/three_bounce_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_btn/loading_btn.dart';

class  OutlinePrimaryLoadingButton extends StatefulWidget {
  final double width;
  final String title;
  final bool disable;
  final Function(
      Function startLoading, Function stopLoading, ButtonState btnState) onTap;

  const  OutlinePrimaryLoadingButton(
      {super.key,
        this.width = double.infinity,
        required this.onTap,
        required this.title,
        required this.disable});

  @override
  State< OutlinePrimaryLoadingButton> createState() => _outlinePrimaryLoadingButtonState();
}

class _outlinePrimaryLoadingButtonState extends State< OutlinePrimaryLoadingButton>
    with TickerProviderStateMixin {
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
      color: widget.disable ? backgroundColor : Colors.white,
      borderSide: BorderSide(color: primaryColor,width: 1),
      width: widget.width,
      elevation: widget.disable ? 0 : 2,
      roundLoadingShape: false,
      disabledColor: primaryColor.withOpacity(0.1),
      loader: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: SpinKitThreeBounce(
              color: primaryColor,
              size: 36,
              controller: animationController,
            )),
      ),
      onTap: widget.onTap,
      child: Text(
        widget.title,
        style: AppTextStyles.outlinedPrimaryButtonText,
      ),
    );
  }
}