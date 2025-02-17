import 'package:flutter/widgets.dart';

class Dimensions {
  static double dynamicHeight(BuildContext context, double value) =>
      MediaQuery.of(context).size.height * value;

  static double dynamicWidth(BuildContext context, double value) =>
      MediaQuery.of(context).size.width * value;
}
