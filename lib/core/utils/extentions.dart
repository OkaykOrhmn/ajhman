extension MinuetsLabel on String {
  String get withLabel{
    return "دقیقه $this";
  }

  String get withOutLabel{
    String a = replaceAll("دقیقه", "").replaceAll(" ", "");
    return a;
  }


}

extension MinuetsToSec on int {
  String get formattedToMinute{
    int timeInSecond = this;
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$second : $minute";
  }
}
