import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:open_table/core/constants/constant.dart';
import 'package:open_table/core/functions/routing.dart';
import 'package:open_table/core/utils/app_text_styles.dart';
import 'package:open_table/core/utils/colors.dart';
import 'package:open_table/core/widgets/custom_back_action.dart';
import 'package:open_table/core/widgets/custom_button.dart';
import 'package:open_table/core/widgets/custom_error.dart';
import 'package:open_table/core/widgets/fav_icon.dart';
import 'package:open_table/features/customer/booking/view/restu_booking_view.dart';
import 'package:open_table/features/customer/booking/widgets/detail_info.dart';
import 'package:open_table/features/models/restaurant_model.dart';

class RestuarentDetailView extends StatefulWidget {
  const RestuarentDetailView({
    super.key,
    required this.model,
  });
  final RestuarentModel model;

  @override
  State<RestuarentDetailView> createState() => _RestuarentDetailViewState();
}

class _RestuarentDetailViewState extends State<RestuarentDetailView> {
  final _message = TextEditingController();

  int rate = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      bottomNavigationBar: (FirebaseAuth.instance.currentUser?.photoURL != '0')
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                color: AppColors.redColor,
                text: 'Delete Restaurent',
                onTap: () {
                  FirebaseFirestore.instance
                      .collection('restaurents')
                      .doc(widget.model.id)
                      .delete();
                  Navigator.pop(context);
                },
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                text: 'Book Now',
                onTap: () {
                  navigateTo(
                      context,
                      RestuarentBookingView(
                        restuarentModel: widget.model,
                      ));
                },
              ),
            ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                        child: Image.network(
                          widget.model.cover ?? '',
                          scale: 4,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Image.asset('assets/logo.png');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(top: 40, left: 35, child: CustomBackAction()),
                Positioned(
                    top: 40,
                    right: 35,
                    child: FavouriteIconWidget(
                      model: widget.model,
                    )),
              ],
            ),
            const Gap(20),
            DetailInfo(
              title: widget.model.name ?? '',
              rating: widget.model.rating.toString(),
              reviews: widget.model.reviews!.length.toString(),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Description',
                style: nunito16.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                widget.model.description ?? '',
                style: nunito14,
              ),
            ),
            const Gap(10),
            Divider(
              color: AppColors.white,
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ExpansionTile(
                collapsedBackgroundColor: AppColors.white,
                collapsedIconColor: AppColors.primary,
                backgroundColor: Colors.transparent,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                childrenPadding: const EdgeInsets.symmetric(vertical: 10),
                subtitle: Text(
                  'Send Your Feedback Now',
                  style: getsmallStyle(),
                ),
                title: Text(
                  'Review',
                  style: getTitleStyle(fontSize: 16),
                ),
                children: [
                  TextFormField(
                    controller: _message,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        fillColor: AppColors.white),
                  ),
                  const Gap(15),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                rate = index + 1;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                (rate <= index)
                                    ? Icons.star_border_purple500_sharp
                                    : Icons.star_purple500_sharp,
                                color: AppColors.primary,
                                size: 27,
                              ),
                            ),
                          ),
                        ).toList(),
                      ),
                      const Spacer(),
                      CustomButton(
                        width: 90,
                        height: 40,
                        radius: 10,
                        text: 'SEND',
                        onTap: () {
                          double totalRating = 0;
                          int totalReviews = widget.model.reviews!.length;

                          for (var review in widget.model.reviews!) {
                            totalRating += review.rate!.toDouble();
                          }

                          double res = totalRating / totalReviews;
                          // update rate in hotel collection
                          FirebaseFirestore.instance
                              .collection('restaurents')
                              .doc(widget.model.id)
                              .update({
                            'rating': (res > 5 ? 5 : res),
                            'reviews': [
                              ...widget.model.reviews!.map((e) => e.toJson()),
                              {
                                'message': _message.text,
                                'rate': rate.toDouble(),
                                'name': FirebaseAuth
                                    .instance.currentUser!.displayName
                              }
                            ]
                          }).then((value) {
                            _message.clear();
                            setState(() {
                              rate = 0;
                            });

                            showErrorDialog(
                                context,
                                'Your Review sent Successfully',
                                AppColors.bottomBarColor);
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
