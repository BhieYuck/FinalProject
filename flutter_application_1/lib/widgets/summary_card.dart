import 'package:flutter/material.dart';

class SummaryCard
    extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SummaryCard({

    super.key,

    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(

      child: Card(

        elevation: 2,

        shape:
        RoundedRectangleBorder(

          borderRadius:
          BorderRadius.circular(
              20),
        ),

        child: Padding(

          padding:
          const EdgeInsets.all(
              14),

          child: Column(

            children: [

              Icon(
                icon,
                color: color,
              ),

              const SizedBox(
                  height: 8),

              Text(title),

              const SizedBox(
                  height: 6),

              Text(

                value,

                style:
                const TextStyle(

                  fontSize: 26,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}