import 'package:auth/core/theme.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  const BigText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.h1,
    );
  }
}

class MediumText extends StatelessWidget {
  final String text;
  const MediumText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.h2,
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;
  const SmallText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.h3,
    );
  }
}
