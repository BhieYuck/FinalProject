import 'package:flutter/material.dart';

class GradientButton
    extends StatelessWidget {

  final String text;

  final VoidCallback onTap;

  const GradientButton({

    super.key,

    required this.text,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        height: 52,

        decoration:
        BoxDecoration(

          borderRadius:
          BorderRadius.circular(
              25),

          gradient:
          const LinearGradient(

            colors: [

              Color(
                  0xff2563EB),

              Color(
                  0xff1D4ED8),

            ],
          ),
        ),

        child: Center(

          child: Text(

            text,

            style:
            const TextStyle(

              color:
              Colors.white,

              fontSize: 18,

              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}