import 'package:flutter/material.dart';

class LittlePrimaryButton extends StatelessWidget {
  final IconData icon;
  final Function()? onClick;

  const LittlePrimaryButton({super.key, required this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
