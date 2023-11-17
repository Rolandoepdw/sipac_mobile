import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/data/user_preferences.dart';


class SipacAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SipacAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences = UserPreferences();
    return AppBar(automaticallyImplyLeading: true, actions: [
      IconButton(
          onPressed: () async {
            await userPreferences.removeUserPreferencesData();
            Navigator.pushNamed(context, 'login');
          },
          icon: const Icon(Icons.logout))
    ]);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
