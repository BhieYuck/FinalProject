import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../widgets/app_header.dart';
import '../widgets/search_box.dart';
import '../widgets/gradient_button.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() =>
      _InventoryScreenState();
}

class _InventoryScreenState
    extends State<InventoryScreen> {

  String search = "";
  String category = "All";

  @override
  Widget build(BuildContext context) {

    final items =
    inventory.where((item) {

      final nameMatch =
      item["name"]
          .toLowerCase()
          .contains(
          search.toLowerCase());

      final categoryMatch =

          category == "All" ||

              item["category"]
                  == category;

      return
          nameMatch &&
              categoryMatch;

    }).toList();

    return Scaffold(

      backgroundColor:
      const Color(0xffF8FAFC),

      appBar:
      const AppHeader(
        title: "Inventory",
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(16),

        child: Column(

          children: [

            SearchBox(

              onChanged: (value) {

                setState(() {

                  search = value;

                });

              },
            ),

            const SizedBox(
                height: 16),

            Row(

              children: [

                tab("All"),
                tab("Foods"),
                tab("Supplies"),

              ],
            ),

            const SizedBox(
                height: 16),

            Expanded(

              child:
              ListView.builder(

                itemCount:
                items.length,

                itemBuilder:
                    (_, i) {

                  final item =
                  items[i];

                  final qty =
                  item["quantity"];

                  final threshold =
                  item["threshold"];

                  String status =
                      "In Stock";

                  Color color =
                  Colors.green;

                  if (qty == 0) {

                    status = "Out";
                    color = Colors.red;

                  }

                  else if (
                  qty <= threshold) {

                    status = "Low";
                    color = Colors.orange;

                  }

                  return Card(

                    elevation: 1,

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(
                          20),
                    ),

                    child:
                    ListTile(

                      onTap: () {

                        editQuantity(
                            item);

                      },

                      onLongPress: () {

                        deleteItem(
                            item);

                      },

                      contentPadding:
                      const EdgeInsets.all(
                          12),

                      title:
                      Text(

                        item["name"],

                        style:
                        const TextStyle(

                          fontWeight:
                          FontWeight.bold,

                          fontSize: 18,
                        ),
                      ),

                      subtitle:
                      Text(

                          "${item["category"]}\n${item["quantity"]} pcs"),

                      trailing:
                      Container(

                        padding:
                        const EdgeInsets.symmetric(

                          horizontal: 10,
                          vertical: 6,

                        ),

                        decoration:
                        BoxDecoration(

                          color:
                          color.withOpacity(
                              .1),

                          borderRadius:
                          BorderRadius.circular(
                              20),
                        ),

                        child:
                        Text(

                          status,

                          style:
                          TextStyle(
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
                height: 12),

            GradientButton(

              text:
              "+ Add Item",

              onTap:
              addItemModal,
            ),

          ],
        ),
      ),
    );
  }

  Widget tab(
      String text) {

    final selected =
        category == text;

    return Expanded(

      child: Padding(

        padding:
        const EdgeInsets.symmetric(
            horizontal: 4),

        child:
        ElevatedButton(

          onPressed: () {

            setState(() {

              category = text;

            });

          },

          style:
          ElevatedButton
              .styleFrom(

            backgroundColor:

            selected

                ? const Color(
                0xff2563EB)

                : Colors.white,

            foregroundColor:

            selected

                ? Colors.white

                : Colors.black,
          ),

          child:
          Text(text),
        ),
      ),
    );
  }

  void addItemModal() {

  final name =
  TextEditingController();

  final qty =
  TextEditingController();

  String category =
      "Foods";

  showDialog(

    context: context,

    builder: (_) {

      return StatefulBuilder(

        builder:
            (_, setDialog) {

          return AlertDialog(

            title:
            const Text(
                "Add Item"),

            content:
            Column(

              mainAxisSize:
              MainAxisSize.min,

              children: [

                TextField(

                  controller:
                  name,

                  decoration:
                  const InputDecoration(

                    labelText:
                    "Name",
                  ),
                ),

                const SizedBox(
                    height: 12),

                TextField(

                  controller:
                  qty,

                  keyboardType:
                  TextInputType.number,

                  decoration:
                  const InputDecoration(

                    labelText:
                    "Quantity",
                  ),
                ),

                const SizedBox(
                    height: 12),

                DropdownButton<
                    String>(

                  isExpanded:
                  true,

                  value:
                  category,

                  items:
                  const [

                    DropdownMenuItem(

                      value:
                      "Foods",

                      child:
                      Text(
                          "Foods"),
                    ),

                    DropdownMenuItem(

                      value:
                      "Supplies",

                      child:
                      Text(
                          "Supplies"),
                    ),

                  ],

                  onChanged:
                      (value) {

                    setDialog(() {

                      category =
                          value!;

                    });

                  },
                ),

              ],
            ),

            actions: [

              ElevatedButton(

                onPressed: () {

                  setState(() {

                    inventory.add({

                      "name":
                      name.text,

                      "category":
                      category,

                      "quantity":
                      int.parse(
                          qty.text),

                      "threshold":
                      5,

                    });

                  });

                  Navigator.pop(
                      context);

                },

                child:
                const Text(
                    "Save"),
              ),

            ],
          );
        },
      );
    },
  );
}

  void editQuantity(
      Map<String, dynamic> item) {

    final controller =
    TextEditingController(

      text:
      item["quantity"]
          .toString(),
    );

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title:
          const Text(
              "Edit Quantity"),

          content:
          TextField(

            controller:
            controller,

            keyboardType:
            TextInputType.number,

            decoration:
            const InputDecoration(

              labelText:
              "Quantity",

            ),
          ),

          actions: [

            ElevatedButton(

              onPressed: () {

                setState(() {

                  item["quantity"] =
                      int.parse(
                          controller
                              .text);

                });

                Navigator.pop(
                    context);

              },

              child:
              const Text(
                  "Save"),
            ),

          ],
        );
      },
    );
  }

  void deleteItem(
      Map<String, dynamic> item) {

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title:
          const Text(
              "Delete Item"),

          content:
          Text(

              "Delete ${item["name"]}?"),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                    context);

              },

              child:
              const Text(
                  "Cancel"),
            ),

            ElevatedButton(

              onPressed: () {

                setState(() {

                  inventory.remove(
                      item);

                });

                Navigator.pop(
                    context);

              },

              child:
              const Text(
                  "Delete"),
            ),

          ],
        );
      },
    );
  }
}