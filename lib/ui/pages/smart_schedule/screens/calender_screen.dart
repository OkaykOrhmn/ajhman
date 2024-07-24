import 'package:flutter/cupertino.dart';

import '../../../../core/utils/app_locale.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/text_styles.dart';
import '../../../widgets/grid/grid_days_view.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Center(
              child: Text(
            ChangeLocale(context).appLocal!.choiceDay,
            textAlign: TextAlign.center,
            style: body1,
          )),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 18, 16, 0),
          child: GridDaysView(),
        ),
        Expanded(child: Assets.image.calendaFrame.image()),
      ],
    );
  }
}
