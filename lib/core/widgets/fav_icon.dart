import 'package:flutter/material.dart';
import 'package:open_table/core/services/firebase_services.dart';
import 'package:open_table/core/utils/colors.dart';
import 'package:open_table/core/widgets/custom_error.dart';
import 'package:open_table/features/models/restaurant_model.dart';

class FavouriteIconWidget extends StatelessWidget {
  const FavouriteIconWidget({
    super.key,
    required this.model,
  });
  final RestuarentModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FirebaseServices.addToFav(
                model: model, user: FirebaseServices.getUser())
            .then((value) {
          showErrorDialog(context, 'Added To Favourite', AppColors.shadeColor);
        });
      },
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 246, 230, 246),
          borderRadius: BorderRadius.circular(13),
        ),
        child: const Icon(Icons.favorite_border_rounded),
      ),
    );
  }
}
