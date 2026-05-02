import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget
    implements PreferredSizeWidget {

  final String title;

  const AppHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return AppBar(

      backgroundColor: Colors.blue,

      elevation: 0,

      foregroundColor: Colors.white,

      leading: const Icon(Icons.arrow_back),

      title: Text(

        title,

        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: 22,
        ),
      ),

      centerTitle: true,

      actions: const [

        Padding(
          padding: EdgeInsets.only(
            right: 16,
          ),
          child: Icon(
            Icons.notifications,
          ),
        )

      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(60);
}