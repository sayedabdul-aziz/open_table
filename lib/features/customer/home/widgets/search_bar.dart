import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_table/core/constants/constant.dart';
import 'package:open_table/core/functions/routing.dart';
import 'package:open_table/features/customer/home/view/search_view.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 109,
                child: TextField(
                  onTap: () {
                    navigateTo(context, const SearchView());
                  },
                  readOnly: true,
                  style: TextStyle(color: kAccentColor),
                  decoration: InputDecoration(
                    hintText: 'Search for restaurants',
                    hintStyle: nunitoRegular12.copyWith(),
                  ),
                ),
              ),
              const SizedBox(width: 17),
              InkWell(
                onTap: () {
                  navigateTo(context, const SearchView());
                },
                child: Container(
                  height: 44,
                  width: 44,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: kShadeColor,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: SvgPicture.asset('assets/icons/search.svg'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
