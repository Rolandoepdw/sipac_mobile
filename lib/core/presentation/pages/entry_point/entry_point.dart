import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sipac_mobile_4/core/presentation/components/side_bar/side_bar.dart';
import 'package:sipac_mobile_4/core/presentation/pages/activities_page/activities_page.dart';
import 'package:sipac_mobile_4/core/presentation/pages/calendar_page/calendar_page.dart';
import 'package:sipac_mobile_4/core/presentation/pages/entry_point/widgets/menu_btn.dart';
import 'package:sipac_mobile_4/core/presentation/pages/home/home_page.dart';
import 'package:sipac_mobile_4/core/utils/menu_model.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  bool isSideBarOpen = false;

  Menu selectedSideMenu = sidebarMenus.first;

  late SMIBool isMenuOpenInput;

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int _actualPageIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CalendarPage(),
    ActivitiesPage(),
    HomePage(),
  ];

  void updateSelectedPage(int index) {
    if (_actualPageIndex != index) {
      setState(() {
        _actualPageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _pages[_actualPageIndex],
          AnimatedPositioned(
            width: screenSize.width * 0.7,
            height: screenSize.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 0 : -screenSize.width * 0.7,
            top: 0,
            child: SideBar(entryPointUpdatePage: updateSelectedPage),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? screenSize.width * 0.7 - 64 : 0,
            top: isSideBarOpen ? 8 : 8,
            child: MenuBtn(
              press: () {
                isMenuOpenInput.value = !isMenuOpenInput.value;
                if (_animationController.value == 0) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                setState(
                  () {
                    isSideBarOpen = !isSideBarOpen;
                  },
                );
              },
              riveOnInit: (artboard) {
                final controller = StateMachineController.fromArtboard(
                    artboard, "State Machine");

                artboard.addController(controller!);

                isMenuOpenInput =
                    controller.findInput<bool>("isOpen") as SMIBool;
                isMenuOpenInput.value = true;
              },
            ),
          ),
        ],
      ),
    );
  }
}
