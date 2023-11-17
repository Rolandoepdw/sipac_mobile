import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/presentation/pages/home/widgets/btm_nav_item.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/utils/menu_model.dart';
import 'package:sipac_mobile_4/core/utils/rive_utils.dart';

class TemporalityButtomNavigationBar extends StatefulWidget {
  const TemporalityButtomNavigationBar({Key? key}) : super(key: key);

  @override
  State<TemporalityButtomNavigationBar> createState() =>
      _TemporalityButtomNavigationBarState();
}

class _TemporalityButtomNavigationBarState
    extends State<TemporalityButtomNavigationBar> {
  Menu selectedBottonNav = bottomNavItems.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding:
            const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.2),
              offset: const Offset(0, 20),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              bottomNavItems.length,
              (index) {
                Menu menu = bottomNavItems[index];
                return BtmNavItem(
                  navBar: menu,
                  press: () {
                    RiveUtils.chnageSMIBoolState(menu.rive.status!);
                    updateSelectedBtmNav(menu);
                  },
                  riveOnInit: (artboard) {
                    menu.rive.status = RiveUtils.getRiveInput(artboard,
                        stateMachineName: menu.rive.stateMachineName);
                  },
                  selectedNav: selectedBottonNav,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }
}
