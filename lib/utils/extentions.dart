extension MinuetsLabel on String {
  String get withLabel{
    return "دقیقه $this";
  }

  String get withOutLabel{
    String a = replaceAll("دقیقه", "");
    return a;
  }
}
