import 'package:flutter/material.dart';
import 'package:open_table/core/utils/colors.dart';
import 'package:open_table/features/admin/home/home_view.dart';
import 'package:open_table/features/admin/wallet/restaurent_wallet_view.dart';
import 'package:open_table/features/profile/profile_view.dart';

class ManagerNavBarView extends StatefulWidget {
  const ManagerNavBarView({super.key});

  @override
  State<ManagerNavBarView> createState() => _ManagerNavBarViewState();
}

class _ManagerNavBarViewState extends State<ManagerNavBarView> {
  int _selectedIndex = 0;
  final List _page = [
    const ManagerHomeView(),
    const RestaurentWalletView(),
    const ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.bottomBarColor,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wallet),
                label: 'Wallet',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ]),
      ),
      body: _page[_selectedIndex],
    );
  }
}
