import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/data/entities/credential.dart';
import 'package:sipac_mobile_4/core/data/user_preferences.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';


class UserInfoCard extends StatelessWidget {
  const UserInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences = UserPreferences();
    Credential credential = credentialFromJson(userPreferences.userData);

    return ListTile(
      leading: CircleAvatar(
          backgroundColor: secondaryColor.withOpacity(0.2),
          child: const Icon(Icons.person_outline, color: secondaryColor)),
      title: Text(credential.name,
          style: const TextStyle(color: secondaryColor, fontSize: 16)),
      subtitle: Text(credential.password, style: const TextStyle(color: secondaryColor, fontSize: 12)),
      // trailing: IconButton(
      //     onPressed: () async {
      //       await userPreferences.removeUserPreferencesData();
      //       Navigator.pushNamed(context, 'login');
      //     },
      //     icon: Icon(Icons.logout, color: secondaryColor)),
    );
  }
}

