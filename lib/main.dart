// @dart=2.9

import 'dart:convert';

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
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/user_controller.dart';
import 'helpers/shared_pref_utils.dart';
import 'models/blog_category.dart';
import 'models/language.dart';
import 'models/messages.dart';
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
    await initLanguage();
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

Future<void> initLanguage() async {
  UserController userController = UserController();
  await userController.getAllAvialbleLanguages();
  if (prefs != null && prefs.containsKey("defalut_language")) {
    print("defalut_language ${prefs.containsKey("defalut_language")}");
    String lng = prefs.getString("defalut_language");
    String localData = prefs.getString("local_data");
    print("lng $lng");
    print("allMessages $localData");
    allMessages.value = Messages.fromJson(json.decode(localData));
    print(allMessages.value);
    languageCode.value = Language.fromJson(json.decode(lng));
  } else {
    print("else ${currentUser.value.name}");
    if (currentUser.value.name != null) {
      allLanguages.forEach((element) {
        if (element.name == currentUser.value.langCode) {
          languageCode.value = Language(
            language: element.language,
            name: element.name,
          );
        }
      });
    }
    await userController.getLanguageFromServer();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Setting> settingList = [];
  List<Blog> blogList = [];
  bool _userLog = false;
  SharedPreferences prefs = GetIt.instance<SharedPreferencesUtils>().prefs;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    initLanguage();
    if (prefs.containsKey('isUserLoggedIn')) {
      _userLog = true;
    } else {
      _userLog = false;
    }
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
                initialRoute: _userLog == true
                    ? '/MainPage'
                    : !prefs.containsKey("defalut_language")
                        ? "/LanguageSelection"
                        : "/AuthPage", //_userLog ? '/LoadSwipePage' : '/AuthPage',
                onGenerateInitialRoutes: (String initialRouteName) {
                  if (initialRouteName == "/LanguageSelection") {
                    return [
                      RouteGenerator.generateRoute(RouteSettings(
                          name: "/LanguageSelection", arguments: false)),
                    ];
                  } else {
                    return [
                      RouteGenerator.generateRoute(
                          RouteSettings(name: initialRouteName)),
                    ];
                  }
                },
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
