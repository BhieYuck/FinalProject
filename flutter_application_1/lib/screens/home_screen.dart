import 'package:flutter/material.dart';

import '../data/app_data.dart';

import '../widgets/app_header.dart';
import '../widgets/search_box.dart';
import '../widgets/summary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    final low =
    inventory.where(
            (e) =>
        e["quantity"]
            <=
            e["threshold"])
        .toList();

    final out =
    inventory.where(
            (e) =>
        e["quantity"] == 0)
        .length;

    return Scaffold(

      backgroundColor:
      const Color(0xffF8FAFC),

      appBar:
      const AppHeader(
        title: "StockTrack",
      ),

      floatingActionButton:
      FloatingActionButton(

        backgroundColor:
        const Color(0xff2563EB),

        onPressed:
        addItemModal,

        child:
        const Icon(Icons.add),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(16),

        child:
        ListView(

          children: [

            const Text(

              "Good Day, Admin! 👋",

              style: TextStyle(

                fontSize: 22,

                fontWeight:
                FontWeight.bold,

              ),
            ),

            const SizedBox(
                height: 16),

            SearchBox(
              onChanged: (_) {},
            ),

            const SizedBox(
                height: 20),

            Row(

              children: [

                SummaryCard(

                  title: "Total",

                  value:
                  "${inventory.length}",

                  icon:
                  Icons.inventory,

                  color:
                  Colors.blue,
                ),

                SummaryCard(

                  title: "Low",

                  value:
                  "${low.length}",

                  icon:
                  Icons.warning,

                  color:
                  Colors.orange,
                ),

                SummaryCard(

                  title: "Out",

                  value: "$out",

                  icon:
                  Icons.close,

                  color:
                  Colors.red,
                ),

              ],
            ),

            const SizedBox(
                height: 20),

            const Text(

              "Low Stock Items",

              style: TextStyle(

                fontWeight:
                FontWeight.bold,

                fontSize: 18,

              ),
            ),

            ...low.map((item) {

              return Card(

                child:
                ListTile(

                  leading:
                  const Icon(

                    Icons.warning,

                    color:
                    Colors.orange,

                  ),

                  title:
                  Text(
                      item["name"]),

                  subtitle:
                  Text(
                      item["category"]),

                  trailing:
                  Text(
                      "${item["quantity"]} left"),
                ),
              );

            }),

            const SizedBox(
                height: 20),

            const Text(

              "Recent Activity",

              style: TextStyle(

                fontWeight:
                FontWeight.bold,

                fontSize: 18,

              ),
            ),

            ...transactions.map((tx) {

              return Card(

                child:
                ListTile(

                  leading:
                  Icon(

                    tx["type"] == "In"

                        ? Icons.add_circle

                        : Icons.remove_circle,

                    color:

                    tx["type"] == "In"

                        ? Colors.green

                        : Colors.red,

                  ),

                  title:
                  Text(
                      tx["name"]),

                  subtitle:
                  Text(
                      tx["date"]),
                ),
              );

            }),

          ],
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

                  DropdownButton<String>(

                    value:
                    category,

                    isExpanded:
                    true,

                    items: const [

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
}