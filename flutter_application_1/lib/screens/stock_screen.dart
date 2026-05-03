import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../widgets/app_header.dart';
import '../widgets/gradient_button.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() =>
      _StockScreenState();
}

class _StockScreenState
    extends State<StockScreen> {

  String filter = "All";

  @override
  Widget build(BuildContext context) {

    final items =
    transactions.where((tx) {

      if (filter == "All") {
        return true;
      }

      return tx["type"] == filter;

    }).toList();

    return Scaffold(

      backgroundColor:
      const Color(0xffF8FAFC),

      appBar:
      const AppHeader(
        title: "Stock Movement",
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(16),

        child: Column(

          children: [

            Row(

              children: [

                tab("All"),
                tab("In"),
                tab("Out"),

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

                  final tx =
                  items[i];

                  return Card(

                    child:
                    ListTile(

                      leading:
                      Icon(

                        tx["type"] == "In"

                            ? Icons.arrow_downward

                            : Icons.arrow_upward,

                        color:

                        tx["type"] == "In"

                            ? Colors.green

                            : Colors.red,
                      ),

                      title:
                      Text(tx["name"]),

                      subtitle:
                      Text(tx["date"]),

                      trailing:
                      Text(

                        tx["type"] == "In"

                            ? "+${tx["qty"]}"

                            : "-${tx["qty"]}",

                        style:
                        TextStyle(

                          color:

                          tx["type"] == "In"

                              ? Colors.green

                              : Colors.red,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            GradientButton(

              text:
              "+ Add Transaction",

              onTap:
              addTransaction,
            ),

          ],
        ),
      ),
    );
  }

  Widget tab(String text) {

    final selected =
        filter == text;

    return Expanded(

      child:
      ElevatedButton(

        onPressed: () {

          setState(() {

            filter = text;

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
        ),

        child:
        Text(text),
      ),
    );
  }

  void addTransaction() {

    Map<String, dynamic>
    selectedItem =
    inventory.first;

    String type = "In";

    final qty =
    TextEditingController();

    showDialog(

      context: context,

      builder: (_) {

        return StatefulBuilder(

          builder:
              (_, setDialog) {

            return AlertDialog(

              title:
              const Text(
                  "Add Transaction"),

              content:
              Column(

                mainAxisSize:
                MainAxisSize.min,

                children: [

                  DropdownButton<
                      Map<String, dynamic>>(

                    isExpanded: true,

                    value:
                    selectedItem,

                    items:
                    inventory.map(
                            (item) {

                          return DropdownMenuItem(

                            value:
                            item,

                            child:
                            Text(
                                item["name"]),
                          );

                        }).toList(),

                    onChanged:
                        (value) {

                      setDialog(() {

                        selectedItem =
                        value!;

                      });

                    },
                  ),

                  const SizedBox(
                      height: 12),

                  DropdownButton<
                      String>(

                    isExpanded:
                    true,

                    value:
                    type,

                    items:
                    const [

                      DropdownMenuItem(

                        value:
                        "In",

                        child:
                        Text("In"),
                      ),

                      DropdownMenuItem(

                        value:
                        "Out",

                        child:
                        Text("Out"),
                      ),

                    ],

                    onChanged:
                        (value) {

                      setDialog(() {

                        type =
                        value!;

                      });

                    },
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

                ],
              ),

              actions: [

                ElevatedButton(

                  onPressed: () {

                    final amount =
                    int.parse(
                        qty.text);

                    setState(() {

                      transactions.add({

                        "name":
                        selectedItem[
                        "name"],

                        "type":
                        type,

                        "qty":
                        amount,

                        "date":
                        "Now",
                      });

                      if (type == "In") {

                        selectedItem[
                        "quantity"] += amount;

                      }

                      else {

                        selectedItem[
                        "quantity"] -= amount;

                      }

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