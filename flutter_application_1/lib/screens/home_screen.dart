import 'package:flutter/material.dart';

import '../models/item_model.dart';

class HomeScreen extends StatelessWidget {

  final List<ItemModel> items;

  final Function(
      String,
      int,
      String,
      ) onAdd;

  const HomeScreen({
    super.key,
    required this.items,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {

    final lowStock =
        items
            .where(
                (e) => e.isLowStock)
            .length;

    return SafeArea(

      child: Padding(
        padding:
        const EdgeInsets.all(16),

        child: Column(

          children: [

            const Text(
              "Hello, User!",
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 20),

            Row(

              children: [

                stat(
                    "Items",
                    items.length
                        .toString()),

                stat(
                    "Low",
                    lowStock
                        .toString()),

              ],
            ),

            const Spacer(),

            ElevatedButton(

              onPressed: () {

                showDialog(

                  context: context,

                  builder: (_){

                    final name =
                    TextEditingController();

                    final qty =
                    TextEditingController();

                    return AlertDialog(

                      title:
                      const Text(
                          "Add Item"),

                      content:
                      Column(

                        mainAxisSize:
                        MainAxisSize
                            .min,

                        children: [

                          TextField(
                            controller:
                            name,

                            decoration:
                            const InputDecoration(
                              hintText:
                              "Name",
                            ),
                          ),

                          TextField(
                            controller:
                            qty,

                            decoration:
                            const InputDecoration(
                              hintText:
                              "Qty",
                            ),
                          ),

                        ],
                      ),

                      actions: [

                        ElevatedButton(

                          onPressed:
                              () {

                            onAdd(
                              name.text,

                              int.parse(
                                  qty.text),

                              "Food",
                            );

                            Navigator.pop(
                                context);

                          },

                          child:
                          const Text(
                              "Save"),
                        )

                      ],
                    );

                  },
                );

              },

              child: const Text(
                  "Add Item"),
            ),

          ],
        ),
      ),
    );
  }

  Widget stat(
      String title,
      String value,
      ) {

    return Expanded(
      child: Card(

        child: Padding(
          padding:
          const EdgeInsets.all(16),

          child: Column(

            children: [

              Text(title),

              Text(
                value,
                style:
                const TextStyle(
                  fontSize: 20,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}