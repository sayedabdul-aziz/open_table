import 'package:flutter/material.dart';
import 'package:open_table/features/customer/home/widgets/home_header.dart';
import 'package:open_table/features/customer/home/widgets/nearby_restuarent.dart';
import 'package:open_table/features/customer/home/widgets/search_bar.dart';
import 'package:open_table/features/customer/home/widgets/top_hotels_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                const HomeHeader(),
                const SearchBarWidget(),
                const TopRestuarentList(),
                const NearByRestuarent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
