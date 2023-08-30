import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../utils/colors.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Color(0xFF4F8962),
            gradient: const LinearGradient(
                colors: [
                  Color(0xFFFD814A),
                  Color(0xFFFC5C4C)
                ]
            )
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.white,
              fontSize: 18,
              fontFamily: "LeagueSpartan",
            ),
          ),
        ),
      ),
    );
  }
}