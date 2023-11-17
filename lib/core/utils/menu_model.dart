import 'package:sipac_mobile_4/core/utils/rive_model.dart';

class Menu {
  final int index;
  final String title;
  final RiveModel rive;

  Menu({required this.index, required this.title, required this.rive});
}

List<Menu> sidebarMenus = [
  Menu(
    index: 0,
    title: "Inicio",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
  ),
  // Menu(
  //   index: 1,
  //   title: "Calendario",
  //   rive: RiveModel(
  //       src: "assets/rive/little_icons.riv",
  //       artboard: "RULES",
  //       stateMachineName: "RULES_Interactivity"),
  // ),
  Menu(
    index: 1,
    title: "Calendario",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "SEARCH",
        stateMachineName: "SEARCH_Interactivity"),
  ),
  Menu(
    index: 2,
    title: "Actividades",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "CHAT",
        stateMachineName: "CHAT_Interactivity"),
  ),
  Menu(
    index: 3,
    title: "Sincronizar",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "REFRESH/RELOAD",
        stateMachineName: "RELOAD_Interactivity"),
  ),
  // Menu(
  //   index: 3,
  //   title: "Help",
  //   rive: RiveModel(
  //       src: "assets/rive/icons.riv",
  //       artboard: "CHAT",
  //       stateMachineName: "CHAT_Interactivity"),
  // ),
];
List<Menu> sidebarMenus2 = [
  Menu(
    index: 0,
    title: "Opciones",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "SETTINGS",
        stateMachineName: "SETTINGS_Interactivity"),
  ),
  // Menu(
  //   index: 0,
  //   title: "History",
  //   rive: RiveModel(
  //       src: "assets/rive/icons.riv",
  //       artboard: "TIMER",
  //       stateMachineName: "TIMER_Interactivity"),
  // ),
  Menu(
    index: 1,
    title: "Notificaciones",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "BELL",
        stateMachineName: "BELL_Interactivity"),
  ),
];

List<Menu> bottomNavItems = [
  Menu(
    index: 0,
    title: "Chat",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "CHAT",
        stateMachineName: "CHAT_Interactivity"),
  ),
  Menu(
    index: 1,
    title: "Search",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "SEARCH",
        stateMachineName: "SEARCH_Interactivity"),
  ),
  Menu(
    index: 2,
    title: "Timer",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "TIMER",
        stateMachineName: "TIMER_Interactivity"),
  ),
  Menu(
    index: 3,
    title: "Notification",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "BELL",
        stateMachineName: "BELL_Interactivity"),
  ),
  Menu(
    index: 4,
    title: "Profile",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
  ),
];
