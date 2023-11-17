import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/utils/menu_model.dart';

class SideMenu extends StatelessWidget {
  const SideMenu(
      {super.key,
      required this.menu,
      required this.press,
      required this.riveOnInit,
      required this.selectedMenu});

  final Menu menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final Menu selectedMenu;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: lowPadding, right: lowPadding),
          child: Divider(color: dividerColor, height: 1),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: duration500,
              curve: fastOutSlowIn,
              width: selectedMenu == menu ? screenSize.width * 0.7 : 0,
              height: 56,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: layer1BlackColor,
                  borderRadius: BorderRadius.all(Radius.circular(lowRadius)),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 36,
                width: 36,
                child: RiveAnimation.asset(
                  menu.rive.src,
                  artboard: menu.rive.artboard,
                  onInit: riveOnInit,
                ),
              ),
              title: Text(
                menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
