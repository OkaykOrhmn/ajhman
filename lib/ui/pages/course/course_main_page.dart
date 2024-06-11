import 'package:ajhman/core/bloc/roadmap/roadmap_bloc.dart';
import 'package:ajhman/core/enum/state_status.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/data/args/course_main_args.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/ui/pages/course/course_info.dart';
import 'package:ajhman/ui/pages/roadmap/roadmap_page.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/animation/animated_visibility.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/image/profile_image_network.dart';
import 'package:ajhman/ui/widgets/listview/highlight_listview.dart';
import 'package:ajhman/ui/widgets/text/icon_info.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';

import '../../../core/bloc/course/main/course_main_bloc.dart';
import '../../../gen/assets.gen.dart';

class CourseMainPage extends StatefulWidget {
  final CourseMainArgs args;

  const CourseMainPage({super.key, required this.args});

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  @override
  void initState() {
    // context.read<CourseMainBloc>().add(GetCourseMainInfo(courseId: widget.args.courseId!));
    context.read<RoadmapBloc>().add(GetRoadMap(courseId: widget.args.courseId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReversibleAppBar(title: "محتوای دوره"),
      body: BlocBuilder<RoadmapBloc, RoadmapState>(
        builder: (context, state) {
            switch (state.status) {
              case StateStatus.success:
                // state.data.chapters!.forEach((element) {
                //   element.isOpen ??= false;
                // });
                // return SingleChildScrollView(
                //     child: CourseInfo(response: state.data));
                return RoadMapPage(response: state.data!, courseId: widget.args.courseId!,);
              case StateStatus.fail:
                return Container(
                  width: 200,
                  height: 200,
                  color: Colors.red,
                  child: const Center(
                    child: Text("error"),
                  ),
                );
              default:
                return Center(
                  child: Gif(
                    image: Assets.gif.roadMapLoading.provider(),
                    autostart: Autostart.loop,
                  ),
                );
            }

        },
      ),
    );
  }
}
