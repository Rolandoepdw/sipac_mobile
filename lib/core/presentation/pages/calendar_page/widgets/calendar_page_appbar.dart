import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';

class CalendarPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CalendarPageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Calendario'),
      centerTitle: true,
      elevation: 0.0,
      bottom: const TabBar(
        indicatorColor: secondaryColor,
        tabs: [
          Text('Diario', style: TextStyle(fontSize: 16)),
          Text('Semanal', style: TextStyle(fontSize: 16)),
          Text('Mensual', style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}
