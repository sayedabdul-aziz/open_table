import 'package:flutter/material.dart';
import 'package:open_table/core/constants/constant.dart';
import 'package:open_table/core/functions/routing.dart';
import 'package:open_table/core/utils/colors.dart';
import 'package:open_table/core/widgets/custom_button.dart';
import 'package:open_table/features/admin/home/add_restaurent.dart';
import 'package:open_table/features/customer/home/widgets/nearby_restuarent.dart';

class ManagerHomeView extends StatelessWidget {
  const ManagerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 50,
                ),
                const SizedBox(height: 11),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hi, Admin 👋', style: nunitoRegular17),
                          Text('Manage Your Orders Now!', style: nunito23),
                          const SizedBox(height: 30),
                          Row(children: [
                            // add hotel button

                            Expanded(
                              child: CustomButton(
                                color: AppColors.primary,
                                text: 'Add Restuarent +',
                                onTap: () {
                                  navigateTo(
                                      context, const AddRestuarentView());
                                },
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
                const NearByRestuarent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
