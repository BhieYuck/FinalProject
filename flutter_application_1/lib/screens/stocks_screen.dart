import 'package:flutter/material.dart';

import '../models/item_model.dart';

import '../widgets/app_header.dart';
import '../widgets/custom_card.dart';

class StocksScreen
    extends StatelessWidget {

  final List<ItemModel> items;

  final Function(
    ItemModel,
  ) onRestock;

  const StocksScreen({
    super.key,
    required this.items,
    required this.onRestock,
  });

  @override
  Widget build(
      BuildContext context) {

    final low =
        items.where(
      (e) => e.isLowStock,
    );

    return Scaffold(

      appBar: const AppHeader(
        title: "Stocks",
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(
          12,
        ),

        child: ListView(

          children: [

            section(
                "Low Stocks"),

            ...low.map((e) {

              return CustomCard(

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    Text(
                      "${e.name}: ${e.quantity} pcs left",
                    ),

                    IconButton(

                      onPressed:
                          () {

                        onRestock(
                            e);

                      },

                      icon:
                          const Icon(
                        Icons.add_circle,
                        color: Colors.orange,
                      ),
                    )

                  ],
                ),
              );
            }),

            const SizedBox(
              height: 20,
            ),

            section(
                "Expiry Alerts"),

            ...items.map((e) {

              return CustomCard(

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    Text(
                        e.name),

                    Text(
                        e.expiryText),

                  ],
                ),
              );
            })

          ],
        ),
      ),
    );
  }

  Widget section(
      String text) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      padding:
          const EdgeInsets.all(
        8,
      ),

      decoration:
          BoxDecoration(

        color: Colors.blue,

        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),

      child: Center(

        child: Text(

          text,

          style:
              const TextStyle(

            color:
                Colors.white,

            fontWeight:
                FontWeight.bold,

            fontSize:
                20,
          ),
        ),
      ),
    );
  }
}