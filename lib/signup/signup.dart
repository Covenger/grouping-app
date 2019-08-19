import 'package:flutter/material.dart';

import 'email.dart';
import 'gender_n_birth.dart';
import 'name.dart';
import 'password.dart';
import 'validate_code.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = '/signup';

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      EmailPage.routeName: (context) => EmailPage(),
      GenderNBirthPage.routeName: (context) => GenderNBirthPage(),
      NamePage.routeName: (context) => NamePage(),
      PasswordPage.routeName: (context) => PasswordPage(),
      ValidateCodePage.routeName: (context) => ValidateCodePage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    // SignUpPage builds its own Navigator which ends up being a nested
    // Navigator in our app.
    return Navigator(
      initialRoute: EmailPage.routeName,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: routeBuilders[settings.name], settings: settings);
      },
    );
  }
}
