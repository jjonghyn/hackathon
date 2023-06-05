import 'package:flutter/cupertino.dart';
import 'package:weather_app/constants/textStyle.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key ? key, required this.textString, required this.style, required this.textAlign,

}) : super(key: key);

  final String textString;
  final TextStyle style;
  final TextAlign textAlign;


  @override
  Widget build(BuildContext context) {
    return Text(
      textString,
      style: font25TextStyle,
      textAlign: TextAlign.center,
    );
  }
}