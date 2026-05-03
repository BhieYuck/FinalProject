import 'package:flutter/material.dart';

import '../data/app_data.dart';

import '../models/item_model.dart';

import '../widgets/app_header.dart';
import '../widgets/search_box.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/category_tab.dart';

class InventoryScreen
    extends StatefulWidget {

  const InventoryScreen({
    super.key,
  });

  @override
  State<InventoryScreen>
  createState() =>
      _InventoryScreenState();
}

class _InventoryScreenState
    extends State<InventoryScreen> {

  String search = "";

  String selectedTab =
      "All";

  final TextEditingController
  nameController =
  TextEditingController();

  final TextEditingController
  quantityController =
  TextEditingController();

  String category =
      "Foods";

  List<ItemModel>
  get filteredItems {

    return inventory.where(
            (item){

          final searchMatch =

          item.name
              .toLowerCase()

              .contains(

              search
                  .toLowerCase());

          final categoryMatch =

          selectedTab
              == "All"

              ||

              item.category
                  ==
                  selectedTab;

          return

              searchMatch
              &&
              categoryMatch;

        }).toList();
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
          "Inventory",
        ),

        floatingActionButton:
        FloatingActionButton(

          backgroundColor:
          const Color(
              0xff2563EB),

          onPressed:
          showAddDialog,

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

              SearchBox(

                onChanged:
                    (value){

                  setState(() {

                    search =
                        value;

                  });

                },
              ),

              const SizedBox(
                  height: 16),

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
                    "Foods",

                    active:

                    selectedTab
                        ==
                        "Foods",

                    onTap:(){

                      setState(() {

                        selectedTab =
                        "Foods";

                      });

                    },
                  ),

                  CategoryTab(

                    text:
                    "Supplies",

                    active:

                    selectedTab
                        ==
                        "Supplies",

                    onTap:(){

                      setState(() {

                        selectedTab =
                        "Supplies";

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

                  filteredItems.map(

                          (item){

                        return buildItemCard(
                            item);

                      }).toList(),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemCard(
      ItemModel item){

    return Card(

      shape:
      RoundedRectangleBorder(

        borderRadius:
        BorderRadius.circular(
            20),
      ),

      child:
      Padding(

        padding:
        const EdgeInsets.all(
            12),

        child:
        Column(

          children: [

            Row(

              children: [

                CircleAvatar(

                  backgroundColor:

                  item.isOut

                      ?

                  Colors.red
                      .withOpacity(
                      .15)

                      :

                  item.isLow

                          ?

                  Colors.orange
                      .withOpacity(
                      .15)

                          :

                  Colors.green
                      .withOpacity(
                      .15),

                  child:
                  Icon(

                    Icons.inventory,

                    color:

                    item.isOut

                        ?

                    Colors.red

                        :

                    item.isLow

                            ?

                    Colors.orange

                            :

                    Colors.green,
                  ),
                ),

                const SizedBox(
                    width: 12),

                Expanded(

                  child:
                  Column(

                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

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
                          item.category),

                    ],
                  ),
                ),

                buildStatusBadge(
                    item),

              ],
            ),

            const SizedBox(
                height: 16),

            Row(

              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

              children: [

                IconButton(

                  onPressed:(){

                    minusQty(
                        item);

                  },

                  icon:
                  const Icon(

                    Icons.remove_circle,

                    color:
                    Colors.red,
                  ),
                ),

                Text(

                  "${item.quantity}",

                  style:
                  const TextStyle(

                    fontSize:
                    22,

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                IconButton(

                  onPressed:(){

                    plusQty(
                        item);

                  },

                  icon:
                  const Icon(

                    Icons.add_circle,

                    color:
                    Colors.green,
                  ),
                ),

                IconButton(

                  onPressed:(){

                    deleteItem(
                        item);

                  },

                  icon:
                  const Icon(

                    Icons.delete,

                    color:
                    Colors.grey,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget buildStatusBadge(
      ItemModel item){

    Color color;

    String text;

    if(item.isOut){

      color =
      Colors.red;

      text =
      "Out";
    }

    else if(item.isLow){

      color =
      Colors.orange;

      text =
      "Low";
    }

    else{

      color =
      Colors.green;

      text =
      "In";
    }

    return Container(

      padding:
      const EdgeInsets.symmetric(

        horizontal: 12,
        vertical: 6,
      ),

      decoration:
      BoxDecoration(

        color:
        color
            .withOpacity(
            .12),

        borderRadius:
        BorderRadius.circular(
            20),
      ),

      child:
      Text(

        text,

        style:
        TextStyle(
          color:
          color,
        ),
      ),
    );
  }

  void plusQty(
      ItemModel item){

    setState(() {

      item.quantity++;

      activities.add(
          "Added 1 ${item.name}");

    });
  }

  void minusQty(
      ItemModel item){

    if(
    item.quantity <= 0){

      return;
    }

    setState(() {

      item.quantity--;

      activities.add(
          "Removed 1 ${item.name}");

    });
  }

  void deleteItem(
      ItemModel item){

    setState(() {

      inventory.remove(
          item);

      activities.add(

          "Deleted ${item.name}");

    });
  }

  void showAddDialog(){

    nameController.clear();

    quantityController
        .clear();

    category =
        "Foods";

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
              "Add Item"),

          content:
          Column(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              TextField(

                controller:
                nameController,

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
                quantityController,

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

                items:

                [

                  "Foods",

                  "Supplies",

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

                    category =
                    value
                    as String;

                  });

                },
              ),

            ],
          ),

          actions: [

            ElevatedButton(

              onPressed:
              saveItem,

              child:
              const Text(
                  "Save"),
            ),

          ],
        );
      },
    );
  }

  void saveItem(){

    if(
    nameController
        .text
        .isEmpty){

      return;
    }

    if(
    quantityController
        .text
        .isEmpty){

      return;
    }

    final item =
    ItemModel(

      name:

      nameController
          .text,

      category:
      category,

      quantity:

      int.parse(

          quantityController
              .text),

      threshold:
      5,
    );

    setState(() {

      inventory.add(
          item);

      activities.add(

          "Added ${item.name}");

    });

    Navigator.pop(
        context);
  }

  @override
  void dispose(){

    nameController.dispose();

    quantityController
        .dispose();

    super.dispose();
  }
}