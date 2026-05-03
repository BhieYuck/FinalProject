import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,

      width: double.infinity,

      child: ElevatedButton(
        onPressed: onTap,

        child: Text(text),
      ),
    );
  }
}