import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:open_table/core/functions/routing.dart';
import 'package:open_table/core/utils/app_text_styles.dart';
import 'package:open_table/core/utils/colors.dart';
import 'package:open_table/features/customer/booking/view/restuarent_details_view.dart';
import 'package:open_table/features/customer/home/widgets/resturent_item.dart';
import 'package:open_table/features/models/restaurant_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchView();
}

class _SearchView extends State<SearchView> {
  String keyy = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Resturants',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      keyy = value;
                    });
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search ..',
                  ),
                )),
              ],
            ),
            const Gap(20),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('restaurents')
                      .orderBy('name')
                      .startAt([keyy]).endAt(['$keyy\uf8ff']).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 150,
                              color: AppColors.accentColor,
                            ),
                            const Gap(20),
                            Text(
                              'No Items',
                              textAlign: TextAlign.center,
                              style: getbodyStyle(
                                fontSize: 16,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          var item = RestuarentModel.fromJson(
                              snapshot.data!.docs[index].data());

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: InkWell(
                              onTap: () {
                                navigateTo(
                                    context, RestuarentDetailView(model: item));
                              },
                              child: ResturentItem(
                                imageUrl: item.cover ?? '',
                                name: item.name ?? '',
                                location: item.location ?? '',
                                rating: item.rating!.toStringAsFixed(1),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
