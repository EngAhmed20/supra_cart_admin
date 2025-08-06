import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/view/login_view.dart';
import '../utilis/constants.dart';

Future<void> signOut(BuildContext context,SharedPreferences sharedPref) async {
  await sharedPref.remove(accessToken);
  await sharedPref.remove(adminInfo);
  Navigator.pushReplacementNamed(context, LoginView.routeName);
  //emit(AuthSignOutSuccess());
}
