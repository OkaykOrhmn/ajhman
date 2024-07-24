import 'package:ajhman/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/text_styles.dart';
import '../../theme/design_config.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hint;
  final Function(String)? onChange;

  const SearchTextField(
      {super.key,
      required this.textEditingController,
      required this.hint,
      required this.onChange});

  @override
  State<SearchTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<SearchTextField> {
  void _onChange(String val) {
    if (widget.onChange != null) {
      widget.onChange!(val);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardBackground(),
        borderRadius: DesignConfig.highBorderRadius,
        boxShadow: DesignConfig.lowShadow,
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Center(
              child: Assets.icon.outline.searchNormal.svg(
                  color: Theme.of(context).disable(), width: 16, height: 16)),
          const SizedBox(
            width: 8,
          ),
          Container(
            color: Theme.of(context).disable(),
            width: 1,
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                controller: widget.textEditingController,
                style: Theme.of(context).textTheme.searchHint.copyWith(
                      decoration: TextDecoration.none,
                    ),
                onChanged: (val) {
                  setState(() {
                    _onChange(val);
                  });
                },
                maxLines: 1,
                autocorrect: false,
                enableSuggestions: false,
                autofocus: true,
                decoration: InputDecoration(
                    suffixIcon: widget.textEditingController.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                widget.textEditingController.clear();
                              });
                            },
                            child: const Icon(
                              CupertinoIcons.xmark,
                              size: 12,
                            ),
                          )
                        : null,
                    filled: true,
                    hintText: widget.hint,
                    fillColor: Theme.of(context).editTextFilled(),
                    hintStyle: AppTextStyles.primaryTextFieldHint,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none),
              ),
            ),
          )
        ],
      ),
    );
  }
}
