import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:open_table/core/utils/colors.dart';
import 'package:open_table/features/customer/booking/view/restuarent_details_view.dart';
import 'package:open_table/features/models/restaurant_model.dart';

import '../../../../core/constants/constant.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({
    super.key,
    required this.model,
  });
  final RestuarentModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RestuarentDetailView(model: model),
            ),
          );
        },
        child: Stack(
          children: [
            Hero(
              tag: model.id ?? 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    model.cover ?? '',
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
            if (FirebaseAuth.instance.currentUser?.photoURL == '0')
              Positioned(
                top: 12,
                right: 12,
                child: ClipOval(
                  child: Container(
                    height: 23,
                    width: 23,
                    color: AppColors.accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        'assets/icons/heart.svg',
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                    color: AppColors.shadeColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            model.name ?? "",
                            style: nunito14.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/star.svg'),
                            const SizedBox(width: 4),
                            Text(
                              '${model.rating!.toStringAsFixed(1)} (${model.reviews?.length})',
                              style: nunito10.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.location_pin,
                          color: Colors.white,
                          size: 15,
                        ),
                        Text(model.location.toString(),
                            style: nunito10.copyWith(color: AppColors.white)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
