import 'package:flutter/material.dart';

import '../data/app_data.dart';

import '../widgets/app_header.dart';
import '../widgets/gradient_button.dart';

class StockScreen
    extends StatefulWidget {

  const StockScreen({
    super.key,
  });

  @override
  State<StockScreen>
  createState() =>
      _StockScreenState();
}

class _StockScreenState
    extends State<
        StockScreen> {

  String filter =
      "All";

  @override
  Widget build(
      BuildContext context) {

    final items =
    transactions.where(
            (tx){

          if(
          filter=="All"){
            return true;
          }

          return
              tx["type"]
                  ==
                  filter;

        }).toList();

    return Scaffold(

      backgroundColor:
      const Color(
          0xffF8FAFC),

      appBar:
      const AppHeader(
        title:
        "Stock Movement",
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(
            16),

        child:
        Column(

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
                    (_, i){

                  final tx =
                  items[i];

                  return Card(

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(
                          20),
                    ),

                    child:
                    ListTile(

                      leading:
                      Icon(

                        tx["type"]=="In"

                            ? Icons.arrow_downward

                            : Icons.arrow_upward,

                        color:

                        tx["type"]=="In"

                            ? Colors.green

                            : Colors.red,
                      ),

                      title:
                      Text(
                          tx["name"]),

                      subtitle:
                      Text(
                          tx["date"]),

                      trailing:
                      Text(

                        tx["type"]=="In"

                            ? "+${tx["qty"]}"

                            : "-${tx["qty"]}",

                        style:
                        TextStyle(

                          color:

                          tx["type"]=="In"

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

  Widget tab(
      String text){

    final selected =
        filter
            ==
            text;

    return Expanded(

      child:
      ElevatedButton(

        onPressed:
            (){

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
        ),

        child:
        Text(text),
      ),
    );
  }

  void addTransaction(){

    setState(() {

      transactions.add({

        "name":
        "Rice",

        "type":
        "In",

        "qty":
        10,

        "date":
        "Now",
      });

    });
  }
}