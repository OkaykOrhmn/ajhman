// ignore_for_file: library_private_types_in_public_api, empty_catches

import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model/t_buttons.dart';

class ToggleButtonsRow extends StatefulWidget {
  final List<TButtons> buttons;

  final Function(int)? extraClick;

  const ToggleButtonsRow({super.key, required this.buttons, this.extraClick});

  @override
  _ToggleButtonsRowState createState() => _ToggleButtonsRowState();
}

class _ToggleButtonsRowState extends State<ToggleButtonsRow> {
  @override
  Widget build(BuildContext context) {
    List<TButtons> buttons = widget.buttons;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(buttons.length, (index) {
        void click() {
          for (int indexBtn = 0; indexBtn < buttons.length; indexBtn++) {
            if (indexBtn == index) {
              buttons[indexBtn].active = true;
            } else {
              buttons[indexBtn].active = false;
            }
          }
          try {
            widget.extraClick!(index);
          } catch (ex) {}
        }

        return Expanded(
          child: buttons[index].active
              ? Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: PrimaryButton(
                    title: buttons[index].name,
                    onClick: () {
                      setState(() {
                        click();
                      });
                    },
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: OutlinedPrimaryButton(
                    title: buttons[index].name,
                    onClick: () {
                      setState(() {
                        click();
                      });
                    },
                  ),
                ),
        );
      }),
    );
  }
}
