//@dart=2.9

import 'package:flutter/material.dart';
import 'package:incite/models/user.dart';

class AppModel {
  ValueNotifier<bool> isDarkModeEnabled = ValueNotifier(false);
  ValueNotifier<bool> isUserLoggedIn = ValueNotifier(false);

  ValueNotifier<Users> currentUser = new ValueNotifier(Users());

  AppModel();

  AppModel.fromMap(Map data) {
    print(data);
    isDarkModeEnabled.value = data['isDarkModeEnabled'] as bool;

    isUserLoggedIn.value = data['isUserLoggedIn'] as bool;
    currentUser.value = data['currentUser'];
  }

  Map toMap() {
    return {
      'isDarkModeEnabled': isDarkModeEnabled.value,
      'isUserLoggedIn': isUserLoggedIn.value,
      'currentUser': currentUser.value
    };
  }
}
