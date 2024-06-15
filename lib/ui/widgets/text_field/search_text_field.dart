import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/utils/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/text/text_styles.dart';
import '../../theme/widget/design_config.dart';
import '../text/primary_text.dart';

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
        color: backgroundColor100,
        borderRadius: DesignConfig.highBorderRadius,
        boxShadow: DesignConfig.lowShadow,
      ),
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 16,),
          Center(child: Assets.icon.outline.searchNormal.svg(color: backgroundColor600,width: 16,height: 16)),
          const SizedBox(width: 8,),
          Container(
            color: backgroundColor600,
            width: 1,
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                controller: widget.textEditingController,
                style: mThemeData.textTheme.searchHint,
                onChanged: (val) {
                  setState(() {
                    _onChange(val);
                  });
                },
                maxLines: 1,

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
                    fillColor: backgroundColor200,
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
