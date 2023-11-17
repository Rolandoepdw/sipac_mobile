import 'package:flutter/material.dart';

/// Flutter code sample for [NavigationDrawer].

class SIPACDestination {
  const SIPACDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<SIPACDestination> destinations = <SIPACDestination>[
  SIPACDestination(
      'page 0', Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
  SIPACDestination(
      'page 1', Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
  SIPACDestination(
      'page 2', Icon(Icons.text_snippet_outlined), Icon(Icons.text_snippet)),
  SIPACDestination(
      'page 3', Icon(Icons.invert_colors_on_outlined), Icon(Icons.opacity)),
];

class SIPACNavigationDrawer extends StatefulWidget {
  const SIPACNavigationDrawer({super.key});

  @override
  State<SIPACNavigationDrawer> createState() =>
      _SIPACNavigationDrawerState();
}

class _SIPACNavigationDrawerState extends State<SIPACNavigationDrawer> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      drawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Header',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ...destinations.map(
            (SIPACDestination destination) {
              return NavigationDrawerDestination(
                label: Text(destination.label),
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
        ],
      ),
      body: Center(child: Text('Page $screenIndex')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildDrawerScaffold(context);
  }
}
