// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_place_app/core/components/components.dart';
import 'package:flutter_place_app/core/constants/colors.dart';

class PlaceCardWidget extends StatelessWidget {
  final String title;
  final String address;
  final String coordinate;
  final VoidCallback onTap;
  const PlaceCardWidget({
    super.key,
    required this.title,
    required this.address,
    required this.coordinate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 130,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.black,
              ),
            ),
            const SpaceHeight(5),
            Text(
              address,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.white,
              ),
            ),
            const SpaceHeight(5),
            Text(
              coordinate,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
