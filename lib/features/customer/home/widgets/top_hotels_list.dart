import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:open_table/features/customer/home/widgets/resturentt_item.dart';
import 'package:open_table/features/models/restaurant_model.dart';

class TopRestuarentList extends StatelessWidget {
  const TopRestuarentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('restaurents')
                .orderBy('rating', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              var hotels = snapshot.data!.docs;
              return Container(
                height: 239,
                margin: const EdgeInsets.only(bottom: 25),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: hotels.length,
                    itemBuilder: (context, index) {
                      RestuarentModel model =
                          RestuarentModel.fromJson(hotels[index].data());

                      return RestaurantItem(model: model);
                    },
                  ),
                ),
              );
            }),
      ],
    );
  }
}
