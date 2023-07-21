// @dart=2.9

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:incite/app_theme.dart';
import 'package:incite/models/app_model.dart';
import 'package:incite/providers/app_provider.dart';
import 'package:incite/repository/user_repository.dart';
import 'package:incite/route_generator.dart';
import 'package:provider/provider.dart';

import 'helpers/shared_pref_utils.dart';
import 'models/blog_category.dart';
import 'models/language.dart';
import 'models/setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// Ideal time to initialize
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  try {
    GetIt.instance.registerSingleton<SharedPreferencesUtils>(
        await SharedPreferencesUtils.getInstance());
    await GlobalConfiguration().loadFromAsset("app_settings");
    print(GlobalConfiguration().get("base_url"));
    getCurrentFontSize();
    getDataFromSharedPrefs();
    getCurrentUser().then((value) {
      if (currentUser.value.auth != null) {
        currentUser.value.isNewUser = false;
      }
    });
  } catch (e) {
    print('error happened $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Setting> settingList = [];
  List<Blog> blogList = [];

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: languageCode,
        builder: (context, Language langue, child) {
          print("languageCode ${langue?.name ?? ""}");

          return ValueListenableBuilder(
            valueListenable: appThemeModel,
            builder: (context, AppModel value, child) {
              print("appThemeModel $appThemeModel");
              return MaterialApp(
                initialRoute:
                    '/MainPage', //_userLog ? '/LoadSwipePage' : '/AuthPage',
                onGenerateRoute: RouteGenerator.generateRoute,
                builder: BotToastInit(), //1. call BotToastInit
                navigatorObservers: [BotToastNavigatorObserver()],
                debugShowCheckedModeBanner: false,
                theme: value.isDarkModeEnabled.value
                    ? getDarkThemeData()
                    : getLightThemeData(),
              );
            },
          );
        });
  }
}
