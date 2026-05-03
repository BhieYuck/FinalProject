import 'package:flutter/material.dart';

import '../data/app_data.dart';

import '../models/item_model.dart';
import '../models/transaction_model.dart';

import '../widgets/app_header.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/category_tab.dart';
import '../widgets/stock_card.dart';

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
    extends State<StockScreen> {

  String selectedTab =
      "All";

  String selectedType =
      "In";

  ItemModel?
  selectedItem;

  final TextEditingController
  quantityController =
  TextEditingController();

  List<TransactionModel>
  get filteredTransactions {

    if(
    selectedTab ==
        "All"){

      return transactions;
    }

    return transactions.where(
            (transaction){

          return

              transaction
                  .type

                  ==

                  selectedTab;

        }).toList();
  }

  @override
  void initState(){

    super.initState();

    if(
    inventory
        .isNotEmpty){

      selectedItem =
      inventory.first;

    }
  }

  @override
  Widget build(
      BuildContext context) {

    return MobileFrame(

      child:
      Scaffold(

        backgroundColor:
        const Color(
            0xffF5F7FB),

        appBar:
        const AppHeader(
          title:
          "Stock",
        ),

        floatingActionButton:
        FloatingActionButton(

          backgroundColor:
          const Color(
              0xff2563EB),

          onPressed:
          showTransactionDialog,

          child:
          const Icon(
              Icons.add),
        ),

        body:
        Padding(

          padding:
          const EdgeInsets.all(
              16),

          child:
          Column(

            children: [

              Row(

                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

                children: [

                  CategoryTab(

                    text:
                    "All",

                    active:

                    selectedTab
                        ==
                        "All",

                    onTap:(){

                      setState(() {

                        selectedTab =
                        "All";

                      });

                    },
                  ),

                  CategoryTab(

                    text:
                    "In",

                    active:

                    selectedTab
                        ==
                        "In",

                    onTap:(){

                      setState(() {

                        selectedTab =
                        "In";

                      });

                    },
                  ),

                  CategoryTab(

                    text:
                    "Out",

                    active:

                    selectedTab
                        ==
                        "Out",

                    onTap:(){

                      setState(() {

                        selectedTab =
                        "Out";

                      });

                    },
                  ),

                ],
              ),

              const SizedBox(
                  height: 20),

              Expanded(

                child:
                ListView(

                  children:

                  filteredTransactions
                      .reversed

                      .map(

                          (transaction){

                        return StockCard(

                          item:

                          transaction
                              .itemName,

                          type:

                          transaction
                              .type,

                          qty:

                          transaction
                              .quantity,

                          date:

                          transaction
                              .date

                              .toString()

                              .substring(
                              0,
                              16),
                        );

                      }).toList(),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void showTransactionDialog(){

    quantityController
        .clear();

    selectedType =
        "In";

    if(
    inventory
        .isNotEmpty){

      selectedItem =
      inventory.first;

    }

    showDialog(

      context:
      context,

      builder:
          (_) {

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

              DropdownButton<ItemModel>(

                value:
                selectedItem,

                isExpanded:
                true,

                items:

                inventory.map(

                        (item){

                      return DropdownMenuItem(

                        value:
                        item,

                        child:
                        Text(
                            item.name),
                      );

                    }).toList(),

                onChanged:
                    (value){

                  setState(() {

                    selectedItem =
                        value;

                  });

                },
              ),

              const SizedBox(
                  height: 12),

              DropdownButton<String>(

                value:
                selectedType,

                isExpanded:
                true,

                items:

                [

                  "In",

                  "Out",

                ].map(

                        (e){

                      return DropdownMenuItem(

                        value:
                        e,

                        child:
                        Text(e),
                      );

                    }).toList(),

                onChanged:
                    (value){

                  setState(() {

                    selectedType =
                    value
                    as String;

                  });

                },
              ),

              const SizedBox(
                  height: 12),

              TextField(

                controller:
                quantityController,

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

              onPressed:
              saveTransaction,

              child:
              const Text(
                  "Save"),
            ),

          ],
        );
      },
    );
  }

  void saveTransaction(){

    if(
    selectedItem
        == null){

      return;
    }

    if(
    quantityController
        .text
        .isEmpty){

      return;
    }

    final qty =
    int.parse(

        quantityController
            .text);

    if(
    selectedType ==
        "Out"

        &&

        selectedItem!
            .quantity

            <

            qty){

      return;
    }

    setState(() {

      if(
      selectedType
          ==
          "In"){

        selectedItem!
            .quantity +=
            qty;
      }

      else{

        selectedItem!
            .quantity -=
            qty;
      }

      transactions.add(

        TransactionModel(

          itemName:

          selectedItem!
              .name,

          type:
          selectedType,

          quantity:
          qty,

          date:
          DateTime.now(),
        ),
      );

      activities.add(

          "$selectedType ${selectedItem!.name}");

    });

    Navigator.pop(
        context);
  }

  @override
  void dispose(){

    quantityController
        .dispose();

    super.dispose();
  }
}