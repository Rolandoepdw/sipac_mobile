import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/presentation/components/side_bar/widgets/info_card.dart';
import 'package:sipac_mobile_4/core/presentation/components/side_bar/widgets/side_menu.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/utils/menu_model.dart';
import 'package:sipac_mobile_4/core/utils/rive_utils.dart';


class SideBar extends StatefulWidget {
  final Function entryPointUpdatePage;

  const SideBar({super.key, required this.entryPointUpdatePage});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Menu selectedSideMenu = sidebarMenus.first;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
        width: screenSize.width * 0.7,
        height: screenSize.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [primaryColor, Colors.deepPurple.shade400])),
        child: SafeArea(
            child: DefaultTextStyle(
                style: const TextStyle(color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UserInfoCard(),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 24, top: 32, bottom: 16),
                            child: Text('Navegación'.toUpperCase())),
                        ...sidebarMenus
                            .map((menu) => SideMenu(
                                  menu: menu,
                                  selectedMenu: selectedSideMenu,
                                  press: () {
                                    RiveUtils.chnageSMIBoolState(
                                        menu.rive.status!);
                                    setState(() {
                                      selectedSideMenu = menu;
                                      widget.entryPointUpdatePage(menu.index);
                                    });
                                  },
                                  riveOnInit: (artboard) {
                                    menu.rive.status = RiveUtils.getRiveInput(
                                        artboard,
                                        stateMachineName:
                                            menu.rive.stateMachineName);
                                  },
                                ))
                            .toList(),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 24, top: 32, bottom: 16),
                            child: Text("Preferencias".toUpperCase())),
                        ...sidebarMenus2
                            .map((menu) => SideMenu(
                                menu: menu,
                                selectedMenu: selectedSideMenu,
                                press: () {
                                  RiveUtils.chnageSMIBoolState(menu.rive.status!);
                                  setState(() {
                                    selectedSideMenu = menu;
                                  });
                                },
                                riveOnInit: (artboard) {
                                  menu.rive.status = RiveUtils.getRiveInput(
                                      artboard,
                                      stateMachineName:
                                          menu.rive.stateMachineName);
                                }))
                            .toList()
                      ]),
                ))));
  }
}
