import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';


successNotification(BuildContext context, String text) {
  ElegantNotification.success(
      title: const Text("Éxito"),
      width: 300,
      background: secondaryColor,
      description: Text(text))
      .show(context);
}

errorNotification(BuildContext context, String text) {
  ElegantNotification.error(
          title: const Text("Error"),
          width: 300,
          background: secondaryColor,
          description: Text(text))
      .show(context);
}

infoNotification(BuildContext context, String text) {
  ElegantNotification.info(
          title: const Text("Información"),
          width: 300,
          background: secondaryColor,
          description: Text(text))
      .show(context);
}
