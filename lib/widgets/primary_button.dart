import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
