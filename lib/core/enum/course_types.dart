import 'package:ajhman/gen/assets.gen.dart';
import 'package:flutter_svg/svg.dart';

enum CourseTypes{
  any("mixed","چند رسانه‌ای","assets/icon/bold-note.svg","assets/icon/outline-note.svg"),
  text("text","متنی","assets/icon/bold/document-text.svg","assets/icon/outline/document-text.svg"),
  video("video","ویدیویی","assets/icon/bold/video.svg","assets/icon/outline/video.svg"),
  audio("audio","صوتی","assets/icon/bold/microphone.svg","assets/icon/outline/microphone.svg"),
  image("image","تصویری","assets/icon/bold/gallery.svg","assets/icon/outline/gallery.svg");

   const CourseTypes(this.type, this.title, this.icon, this.outlined);

  final String type;
  final String title;
  final String icon;
  final String outlined;
}
