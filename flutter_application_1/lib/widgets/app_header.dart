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

      backgroundColor:
      Colors.white,

      elevation: 0,

      foregroundColor:
      Colors.black,

      leading:
      const Icon(Icons.menu),

      centerTitle: true,

      title: Text(

        title,

        style: const TextStyle(

          fontWeight:
          FontWeight.bold,

          fontSize: 24,
        ),
      ),

      actions: const [

        Padding(

          padding:
          EdgeInsets.only(
              right: 14),

          child:
          Icon(
              Icons.notifications_none),
        )

      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(60);
}
