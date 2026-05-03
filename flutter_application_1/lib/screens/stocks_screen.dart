import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../widgets/app_header.dart';

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

    final filtered =
    transactions.where(
            (tx) {

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

      floatingActionButton:
      FloatingActionButton(

        backgroundColor:
        const Color(0xff2563EB),

        onPressed:
        addTransaction,

        child:
        const Icon(Icons.add),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(16),

        child: Column(

          children: [

            Row(

              children: [

                buildTab("All"),

                buildTab("In"),

                buildTab("Out"),

              ],
            ),

            const SizedBox(height: 16),

            Expanded(

              child:
              ListView.builder(

                itemCount:
                filtered.length,

                itemBuilder:
                    (_, index) {

                  final tx =
                  filtered[index];

                  final isIn =
                      tx["type"] == "In";

                  return Card(

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(20),
                    ),

                    child:
                    ListTile(

                      leading:
                      CircleAvatar(

                        backgroundColor:

                        isIn

                            ? Colors.green
                                .withOpacity(.15)

                            : Colors.red
                                .withOpacity(.15),

                        child:
                        Icon(

                          isIn

                              ? Icons.arrow_downward

                              : Icons.arrow_upward,

                          color:

                          isIn

                              ? Colors.green

                              : Colors.red,
                        ),
                      ),

                      title:
                      Text(

                        tx["name"],

                        style:
                        const TextStyle(

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      subtitle:
                      Text(tx["date"]),

                      trailing:
                      Text(

                        isIn

                            ? "+${tx["qty"]}"

                            : "-${tx["qty"]}",

                        style:
                        TextStyle(

                          fontWeight:
                          FontWeight.bold,

                          color:

                          isIn

                              ? Colors.green

                              : Colors.red,

                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildTab(
      String text) {

    final selected =
        filter == text;

    return Expanded(

      child: Padding(

        padding:
        const EdgeInsets.symmetric(
            horizontal: 4),

        child:
        ElevatedButton(

          onPressed: () {

            setState(() {

              filter =
                  text;

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

            elevation: 0,

            shape:
            RoundedRectangleBorder(

              borderRadius:
              BorderRadius.circular(
                  20),
            ),
          ),

          child:
          Text(text),
        ),
      ),
    );
  }

  void addTransaction() {

    if (inventory.isEmpty) {
      return;
    }

    String itemName =
    inventory.first["name"]
        as String;

    String type = "In";

    final qtyController =
    TextEditingController();

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          shape:
          RoundedRectangleBorder(

            borderRadius:
            BorderRadius.circular(
                20),
          ),

          title:
          const Text(
              "Add Transaction"),

          content:
          Column(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              DropdownButton<String>(

                isExpanded: true,

                value:
                itemName,

                items:

                inventory.map(
                        (item) {

                      return DropdownMenuItem<String>(

                        value:
                        item["name"]
                        as String,

                        child:
                        Text(
                            item["name"]),
                      );

                    }).toList(),

                onChanged:
                    (value) {

                  setState(() {

                    itemName =
                    value
                    as String;

                  });

                },
              ),

              const SizedBox(
                  height: 12),

              DropdownButton<String>(

                isExpanded: true,

                value:
                type,

                items:

                ["In", "Out"]
                    .map(

                        (e) {

                      return DropdownMenuItem<String>(

                        value: e,

                        child:
                        Text(e),
                      );

                    }).toList(),

                onChanged:
                    (value) {

                  setState(() {

                    type =
                    value
                    as String;

                  });

                },
              ),

              const SizedBox(
                  height: 12),

              TextField(

                controller:
                qtyController,

                keyboardType:
                TextInputType.number,

                decoration:
                const InputDecoration(

                  labelText:
                  "Quantity",

                  border:
                  OutlineInputBorder(),
                ),
              ),

            ],
          ),

          actions: [

            ElevatedButton(

              onPressed: () {

                if (qtyController
                    .text
                    .isEmpty) {
                  return;
                }

                final qty =
                int.parse(
                    qtyController
                        .text);

                setState(() {

                  transactions.add({

                    "name":
                    itemName,

                    "type":
                    type,

                    "qty":
                    qty,

                    "date":
                    "Now",

                  });

                  final item =
                  inventory.firstWhere(

                          (e) {

                        return
                            e["name"]
                                ==
                                itemName;

                      });

                  if (type == "In") {

                    item["quantity"] +=
                        qty;

                  } else {

                    item["quantity"] -=
                        qty;

                    if (item[
                    "quantity"] <
                        0) {

                      item[
                      "quantity"] = 0;
                    }
                  }

                });

                Navigator.pop(
                    context);

              },

              style:
              ElevatedButton
                  .styleFrom(

                backgroundColor:
                const Color(
                    0xff2563EB),
              ),

              child:
              const Text(
                  "Save"),
            ),

          ],
        );
      },
    );
  }
}