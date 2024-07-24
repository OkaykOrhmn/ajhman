import 'package:ajhman/core/utils/extentions.dart';

class Calculations {
  String getMinInputValue(String be, String next) {
    be.withOutLabel;
    next.withOutLabel;
    String resultVal = be + next;
    return resultVal.toString().withLabel;
  }
}
