import 'package:flutter/material.dart';

import '../models/item_model.dart';

import '../widgets/app_header.dart';
import '../widgets/custom_card.dart';

class InventoryScreen
    extends StatefulWidget {

  final List<ItemModel> items;

  final Function(
    String,
    int,
    String,
  ) onAdd;

  const InventoryScreen({
    super.key,
    required this.items,
    required this.onAdd,
  });

  @override
  State<InventoryScreen>
      createState() =>
          _InventoryScreenState();
}

class _InventoryScreenState
    extends State<
        InventoryScreen> {

  String category = "All";

  String search = "";

  @override
  Widget build(
      BuildContext context) {

    final filtered =
        widget.items.where((e) {

      final categoryMatch =
          category == "All" ||
              e.category ==
                  category;

      final searchMatch = e.name
          .toLowerCase()
          .contains(
              search.toLowerCase());

      return categoryMatch &&
          searchMatch;
    }).toList();

    return Scaffold(

      appBar: const AppHeader(
        title: "Inventory",
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(
          12,
        ),

        child: Column(

          children: [

            TextField(

              onChanged: (value) {

                setState(() {
                  search = value;
                });

              },

              decoration:
                  InputDecoration(

                hintText:
                    "Search...",

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius
                          .circular(
                    30,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Row(

              children: [

                filterButton(
                    "All"),

                filterButton(
                    "Food"),

                filterButton(
                    "Supplies"),

              ],
            ),

            const SizedBox(
              height: 12,
            ),

            Expanded(

              child:
                  ListView.builder(

                itemCount:
                    filtered
                        .length,

                itemBuilder:
                    (_, index) {

                  final item =
                      filtered[
                          index];

                  return CustomCard(

                    child:
                        Row(

                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        Text(

                          item.name,

                          style:
                              const TextStyle(
                            fontSize:
                                18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Text(
                          "${item.quantity} pcs",
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),

            ElevatedButton.icon(

              style:
                  ElevatedButton
                      .styleFrom(
                backgroundColor:
                    Colors.blue,
              ),

              onPressed:
                  showAddDialog,

              icon:
                  const Icon(
                Icons.add,
              ),

              label:
                  const Text(
                "Add Item",
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget filterButton(
      String text) {

    return Expanded(

      child: Padding(

        padding:
            const EdgeInsets.all(
                4),

        child:
            ElevatedButton(

          style:
              ElevatedButton
                  .styleFrom(

            backgroundColor:
                category ==
                        text
                    ? Colors
                        .blue
                    : Colors
                        .blue
                        .shade200,
          ),

          onPressed: () {

            setState(() {
              category = text;
            });

          },

          child: Text(
            text,
          ),
        ),
      ),
    );
  }

  void showAddDialog() {

    final name =
        TextEditingController();

    final qty =
        TextEditingController();

    String cat = "Food";

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            "Add Item",
          ),

          content:
              Column(

            mainAxisSize:
                MainAxisSize
                    .min,

            children: [

              TextField(
                controller:
                    name,
              ),

              TextField(
                controller:
                    qty,
              ),

              DropdownButton(

                value: cat,

                items:
                    const [

                  DropdownMenuItem(
                    value:
                        "Food",
                    child:
                        Text(
                      "Food",
                    ),
                  ),

                  DropdownMenuItem(
                    value:
                        "Supplies",
                    child:
                        Text(
                      "Supplies",
                    ),
                  ),

                ],

                onChanged:
                    (value) {

                  cat =
                      value!;
                },
              )

            ],
          ),

          actions: [

            ElevatedButton(

              onPressed: () {

                widget.onAdd(

                  name.text,

                  int.parse(
                      qty.text),

                  cat,
                );

                Navigator.pop(
                    context);

              },

              child:
                  const Text(
                "Save",
              ),
            )

          ],
        );
      },
    );
  }
}