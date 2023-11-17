import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/presentation/components/side_bar/widgets/info_card.dart';
import 'package:sipac_mobile_4/core/presentation/components/side_bar/widgets/side_menu.dart';
import 'package:sipac_mobile_4/core/utils/menu_model.dart';
import 'package:sipac_mobile_4/core/utils/rive_utils.dart';

class SipacDrawer extends StatefulWidget {
  final Function updatePage;

  const SipacDrawer({super.key, required this.updatePage});

  @override
  State<SipacDrawer> createState() => _SipacDrawerState();
}

class _SipacDrawerState extends State<SipacDrawer> {
  Menu selectedSideMenu = sidebarMenus.first;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Drawer(
      width: screenSize.width * 0.7,
      elevation: 12,
      child: Container(
          height: screenSize.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.deepPurple, Colors.purple])),
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
                                        // widget.updatePage(menu.index);
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
                              child: Text("Historial".toUpperCase())),
                          ...sidebarMenus2
                              .map((menu) => SideMenu(
                                  menu: menu,
                                  selectedMenu: selectedSideMenu,
                                  press: () {
                                    RiveUtils.chnageSMIBoolState(
                                        menu.rive.status!);
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
                  )))),
    );
  }
}
