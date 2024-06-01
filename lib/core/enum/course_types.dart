import 'package:ajhman/gen/assets.gen.dart';
import 'package:flutter_svg/svg.dart';

enum CourseTypes{
  text("text","نوشته","assets/icon/bold/document-text.svg"),
  video("video","ویدیو","assets/icon/bold/video.svg"),
  audio("audio","صدا","assets/icon/bold/microphone.svg"),
  image("image","عکس","assets/icon/bold/gallery.svg");

   const CourseTypes(this.type, this.title, this.icon);

  final String type;
  final String title;
  final String icon;
}
