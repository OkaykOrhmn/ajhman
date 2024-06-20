import 'package:ajhman/core/cubit/summery/summery_cubit.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/data/model/summary_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/loading/three_bounce_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../../widgets/listview/highlight_listview.dart';
import '../../widgets/text/primary_text.dart';

class SummeryPage extends StatefulWidget {
  final int id;

  const SummeryPage({super.key, required this.id});

  @override
  State<SummeryPage> createState() => _SummeryPageState();
}

class _SummeryPageState extends State<SummeryPage> {
  @override
  void initState() {
    context.read<SummeryCubit>().getSummery(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ReversibleAppBar(title: "جمع بندی دوره"),
        backgroundColor: Theme.of(context).background(),
        body: BlocBuilder<SummeryCubit, SummaryModel>(
          builder: (context, state) {
            if (state.summary == null) {
              return const ThreeBounceLoading();
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        PrimaryText(
                            text: "جمع‌بندی دوره فنون مذاکره",
                            style: Theme.of(context).textTheme.dialogTitle,
                            color: Theme.of(context).headText()),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: DesignConfig.highBorderRadius,
                              boxShadow: DesignConfig.lowShadow,
                              color: Theme.of(context).white()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryText(
                                  text: "نکات مهم اشاره شده در دوره",
                                  style: Theme.of(context).textTheme.titleBold,
                                  color: Theme.of(context).headText()),
                              SizedBox(
                                height: 16,
                              ),
                              HighlightListView(
                                items: state.summary!,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: OutlinedPrimaryButton(
                        title: "رفتن به صفحه آزمون",
                        onClick: () {
                          Navigator.of(context).pushNamed(RoutePaths.examInfo,
                              arguments: widget.id);
                        },
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
