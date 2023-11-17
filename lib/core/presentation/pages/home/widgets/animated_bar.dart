import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(bottom: 2),
      duration: const Duration(milliseconds: 200),
      height: 4,
      width: isActive ? 24 : 0,
      decoration: BoxDecoration(
          color: primaryColor, //Color(0xFF81B4FF),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          )),
    );
  }
}
