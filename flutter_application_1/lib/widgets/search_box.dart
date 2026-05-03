import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {

  final Function(String)
  onChanged;

  const SearchBox({

    super.key,

    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      onChanged:
      onChanged,

      decoration:
      InputDecoration(

        hintText:
        "Search items...",

        prefixIcon:
        const Icon(
            Icons.search),

        filled: true,

        fillColor:
        Colors.white,

        border:
        OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(
              16),

          borderSide:
          BorderSide.none,
        ),
      ),
    );
  }
}