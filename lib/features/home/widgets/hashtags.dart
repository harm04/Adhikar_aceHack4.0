import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';

class HashTags extends StatelessWidget {
  final String text;
  const HashTags({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textspans = [];
    text.split(' ').forEach((element) {
      if (element.startsWith('#')) {
        textspans.add(TextSpan(
            text: '$element ',
            style: TextStyle(
                color: Pallete.blueColor,
                fontSize: 18,
                )));
      } else if (element.startsWith('https://') ||
          element.startsWith('http') ||
          element.startsWith('www')) {
        textspans.add(TextSpan(
            text: '$element ',
            style: TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
            )));
      } else {
        textspans.add(TextSpan(
            text: '$element ',
            style: TextStyle(
              color: Pallete.backgroundColor,
              fontSize: 18,
            )));
      }
    });
    return RichText(text: TextSpan(children: textspans));
  }
}
