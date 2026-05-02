import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  final Widget child;

  const CustomCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      padding: const EdgeInsets.all(
        12,
      ),

      decoration: BoxDecoration(

        color: Colors.blue.shade300,

        borderRadius:
        BorderRadius.circular(
          18,
        ),

        border: Border.all(
          color: Colors.black54,
        ),

        boxShadow: [

          BoxShadow(
            blurRadius: 4,
            color: Colors.black
                .withOpacity(.1),
          )

        ],
      ),

      child: child,
    );
  }
}