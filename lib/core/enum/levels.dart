enum Levels {
  vryLow("",""),
  low("آسان","Basic"),
  medium("متوسط","Intermidiate"),
  high("سخت","Advance");

  const Levels(this.value,this.enValue);

  final String value;
  final String enValue;
}
