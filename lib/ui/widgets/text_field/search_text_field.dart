
import 'package:ajhman/ui/theme/color/colors.dart';
import '../../../../core/utils/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/text/text_styles.dart';
import '../../theme/widget/design_config.dart';

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
    ThemeData themeData = Theme.of(context);
    return SizedBox(
      child: TextField(
        controller: widget.textEditingController,
        style: themeData.textTheme.searchHint,
        onChanged: (val) {
          setState(() {
            _onChange(val);
          });
        },
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
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorMain),
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorMain),
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
        ),
      ),
    );
  }
}
