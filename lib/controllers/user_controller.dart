//@dart=2.9
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:incite/elements/reset_password_sheet.dart';
import 'package:incite/elements/sign_in_bottom_sheet.dart';
import 'package:incite/pages/SwipeablePage.dart';
import 'package:incite/pages/home_page.dart';
import 'package:incite/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_theme.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

SharedPreferences prefs;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class UserController extends ControllerMVC {
  Users user = new Users();
  bool hidePassword = true;
  bool loading = false;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> updateFormKey;
  GlobalKey<FormState> signupFormKey;
  GlobalKey<FormState> forgetFormKey;
  GlobalKey<FormState> resetFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  FirebaseMessaging _firebaseMessaging;

  bool _isLoading = false;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    updateFormKey = new GlobalKey<FormState>();
    signupFormKey = new GlobalKey<FormState>();
    forgetFormKey = new GlobalKey<FormState>();
    resetFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    _firebaseMessaging = FirebaseMessaging.instance;
    notificationInit();
    _firebaseMessaging.getToken().then((String _deviceToken) {
      print("_deviceToken ${_deviceToken}");
      user.deviceToken = _deviceToken;
      updateToken();
    }).catchError((e) {
      print('Notification not configured');
    });
  }

  // void googleLogin(GlobalKey<ScaffoldState> scKey) async {
  //   BotToast.showLoading();
  //   try {
  //     GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  //     print("googleSignInAccount $googleSignInAccount");
  //     repository.googleLogin(googleSignInAccount).then((value) async {
  //       print("value $value");
  //       if (value != null && value.apiToken != null) {
  //         await getLanguageFromServer();
  //         Navigator.of(scKey.currentContext).pushReplacement(MaterialPageRoute(
  //           builder: (context) => HomePage(),
  //         ));
  //         Navigator.of(scKey.currentContext).push(MaterialPageRoute(
  //           builder: (context) => SwipeablePage(0),
  //         ));
  //       } else {
  //         ScaffoldMessenger.of(scKey.currentContext).showSnackBar(SnackBar(
  //           content: Text(repository.allMessages.value.wrongEmailAndPassword),
  //         ));
  //       }
  //     }).catchError((e) {
  //       print(e);
  //
  //       ScaffoldMessenger.of(scKey.currentContext).showSnackBar(SnackBar(
  //         content: Text(repository.allMessages.value.emailNotExist),
  //       ));
  //     }).whenComplete(() {
  //       BotToast.closeAllLoading();
  //     });
  //   } catch (e) {
  //     BotToast.closeAllLoading();
  //     print(e);
  //     BotToast.showCustomText(toastBuilder: (_) => Text(e.toString()));
  //   }
  // }

  void login(GlobalKey<ScaffoldState> scKey) async {
    print(user);
    if (user.password != "") {
      if (loginFormKey.currentState.validate()) {
        loginFormKey.currentState.save();
        BotToast.showLoading();
        repository.login(user).then((value) async {
          print("value $value ${value.apiToken}");
          if (value != null && value.apiToken != null) {
            // await getLanguageFromServer();
            print("in if");
            // Get.offAll(HomePage());
            Navigator.of(scKey.currentContext).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => HomePageLoadingScreen()),
                (Route<dynamic> route) => false);
            Navigator.of(scKey.currentContext).push(MaterialPageRoute(
              builder: (context) => SwipeablePage(0),
            ));
          } else {
            print("else error");
          }
        }).catchError((e) {
          print("catch error");
        }).whenComplete(() {
          BotToast.closeAllLoading();
        });
      } else {
        print("login validate fail");
      }
    } else {
      repository.login(user).then((value) {
        if (value != null && value.apiToken != null) {
          Navigator.of(scKey.currentContext).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePageLoadingScreen()),
              (Route<dynamic> route) => false);
          Navigator.of(scKey.currentContext).push(MaterialPageRoute(
            builder: (context) => SwipeablePage(0),
          ));
          // Navigator.of(scKey.currentContext)
          //     .pushReplacementNamed('/MainPage', arguments: false);
        } else {
          ScaffoldMessenger.of(scKey.currentContext).showSnackBar(SnackBar(
            content: Text(repository.allMessages.value.wrongEmailAndPassword),
          ));
        }
      }).catchError((e) {
        BotToast.closeAllLoading();
        ScaffoldMessenger.of(scKey.currentContext).showSnackBar(SnackBar(
          content: Text(repository.allMessages.value.emailNotExist),
        ));
      }).whenComplete(() {
        BotToast.closeAllLoading();
      });
    }
  }

  void register(GlobalKey<ScaffoldState> scKey) async {
    if (signupFormKey.currentState.validate()) {
      print("dfsa");
      signupFormKey.currentState.save();
      BotToast.showLoading();
      repository.register(user).then((value) {
        if (value != null && value.apiToken != null) {
          Navigator.of(scKey.currentContext).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePageLoadingScreen()),
              (Route<dynamic> route) => false);
          Navigator.of(scKey.currentContext).push(MaterialPageRoute(
            builder: (context) => SwipeablePage(0),
          ));
        } else {
          ScaffoldMessenger.of(scKey.currentContext).showSnackBar(SnackBar(
            content: Text(repository.allMessages.value.wrongEmailAndPassword),
          ));
        }
      }).catchError((e) {
        BotToast.closeAllLoading();
        ScaffoldMessenger.of(scKey.currentContext).showSnackBar(SnackBar(
          content: Text(repository.allMessages.value.emailNotExist),
        ));
      }).whenComplete(() {
        BotToast.closeAllLoading();
      });
    }
  }

  void forgetPassword(
      GlobalKey<ScaffoldState> scKey, BuildContext context) async {
    if (forgetFormKey.currentState.validate()) {
      forgetFormKey.currentState.save();
      BotToast.showLoading();
      repository.forgetPassword(user).then((value) async {
        BotToast.closeAllLoading();
        print("value $value");

        if (value != null) {
          Fluttertoast.showToast(
              msg: "OTP sent to your email address",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white);
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: scKey.currentContext,
              builder: (context) {
                return ResetPasswordSheet(scKey, user.email);
              });
        } else {
          print("else ");
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Error",
                style: Theme.of(context).textTheme.bodyText1.merge(
                      TextStyle(
                          color: appThemeModel.value.isDarkModeEnabled.value
                              ? Colors.white
                              : Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal),
                    ),
              ),
              content: Text("Something Went Wrong Try Again Later."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(allMessages.value.ok),
                ),
              ],
            ),
          );
        }
      }).whenComplete(() {});
    }
  }

  void resetPassword(GlobalKey<ScaffoldState> scKeys, String email) async {
    if (resetFormKey.currentState.validate()) {
      resetFormKey.currentState.save();
      repository.resetPassword(user, email).then((value) async {
        if (value != null && value == true) {
          showCustomDialog(
              context: scKeys.currentContext,
              text: "Your password reset successfully",
              title: "Success",
              onTap: () {
                Navigator.pop(scKeys.currentContext);
                Navigator.pop(scKeys.currentContext);
                Navigator.pop(scKeys.currentContext);
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: scKeys.currentContext,
                  builder: (context) {
                    return SignInBottomSheet(scKeys);
                  },
                );
              });
        } else {
          showCustomDialog(
              context: scKeys.currentContext,
              text: "Something went wrong",
              title: "Error",
              onTap: () {
                Navigator.pop(scKeys.currentContext);
              });
        }
      }).whenComplete(() {});
    }
  }

  showCustomDialog(
      {BuildContext context, String title, String text, Function onTap}) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1.merge(
                TextStyle(
                    color: appThemeModel.value.isDarkModeEnabled.value
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal),
              ),
        ),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: onTap,
            child: Text(allMessages.value.ok),
          ),
        ],
      ),
    );
  }

  void profile() async {
    if (updateFormKey.currentState.validate()) {
      updateFormKey.currentState.save();
      repository.update(user).then((value) {
        if (value != null && value.apiToken != null) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(scaffoldKey.currentContext)
              .showSnackBar(SnackBar(
            content: Text(repository.allMessages.value.profileUpdated),
          ));
        }
      }).catchError((e) {
        ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
          content: Text(repository.allMessages.value.emailNotExist),
        ));
      }).whenComplete(() {});
    }
  }

  void updateLanguage() async {
    repository.updateLanguage().then((value) {
      if (value != null && value.apiToken != null) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
          content: Text(repository.allMessages.value.profileUpdated),
        ));
      }
    }).catchError((e) {
      ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
        content: Text(repository.allMessages.value.emailNotExist),
      ));
    }).whenComplete(() {});
  }

  Future<void> getLanguageFromServer() async {
    await repository.getLocalText().then((value) {
      if (value != null) {
        repository.allMessages.value = value;
        print("repository ${repository.allMessages.value.skip}");
      }
      return;
    }).catchError((e) {
      ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
        content: Text(repository.allMessages.value.noLanguageFound),
      ));
      throw e;
    });
  }

  getAllAvialbleLanguages() async {
    await repository.getAllLanguages().then((value) {
      if (value != null) {
        repository.allLanguages = value;
      }
    }).catchError((e) {
      ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
        content: Text(repository.allMessages.value.noLanguageFound),
      ));
    }).whenComplete(() {});
  }

  void updateToken() async {
    repository
        .updateToken(user)
        .then((value) {})
        .catchError((e) {})
        .whenComplete(() {});
  }

  Future<void> notificationInit() async {
    //
    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    // _firebaseMessaging.configure(
    //   onBackgroundMessage: null,
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     showNotificationWithDefaultSound(message);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     showNotificationWithDefaultSound(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true, provisional: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    // await _firebaseMessaging.requestNotificationPermissions();
  }

  Future<dynamic> onSelectNotification(String payload) async {}

  Future<void> googleLogin(GlobalKey<ScaffoldState> scKey) async {
    try {
      BotToast.showLoading();
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      FirebaseAuth auth = FirebaseAuth.instance;
      User user;
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
      repository.googleLogin(user).then((value) async {
        print("value $value");
        if (value != null && value.apiToken != null) {
          await getLanguageFromServer();
          Navigator.of(scKey.currentContext).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePageLoadingScreen(),
          ));
          Navigator.of(scKey.currentContext).push(MaterialPageRoute(
            builder: (context) => SwipeablePage(0),
          ));
        } else {
          ScaffoldMessenger.of(scKey.currentContext).showSnackBar(SnackBar(
            content: Text(repository.allMessages.value.wrongEmailAndPassword),
          ));
        }
        BotToast.closeAllLoading();
      }).catchError((e) {
        BotToast.closeAllLoading();
        BotToast.showCustomText(toastBuilder: (_) => Text(e.toString()));
        throw e;
      });
    } catch (e) {
      BotToast.closeAllLoading();
    }
  }

  // Future<void> googleLogin(GlobalKey<ScaffoldState> scKey) async {
  //   try {
  //     BotToast.showLoading();
  //     // GoogleSignIn _googleSignIn = GoogleSignIn(
  //     //   scopes: [
  //     //     'email',
  //     //   ],
  //     // );
  //     // final GoogleSignInAccount googleSignInAccount =
  //     //     await _googleSignIn.signIn();
  //     // final GoogleSignInAuthentication googleAuthentication =
  //     //     await googleSignInAccount.authentication;
  //     // final AuthCredential credential = GoogleAuthProvider.credential(
  //     //     accessToken: googleAuthentication.accessToken,
  //     //     idToken: googleAuthentication.idToken);
  //     // final UserCredential authResult =
  //     //     await firebaseAuth.signInWithCredential(credential);
  //     User user = await firebaseAuth.s(context: context);
  //     repository.googleLogin(authResult).then((value) async {
  //       print("value $value");
  //       if (value != null && value.apiToken != null) {
  //         await getLanguageFromServer();
  //         Navigator.of(scKey.currentContext).pushReplacement(MaterialPageRoute(
  //           builder: (context) => HomePage(),
  //         ));
  //         Navigator.of(scKey.currentContext).push(MaterialPageRoute(
  //           builder: (context) => SwipeablePage(0),
  //         ));
  //       } else {
  //         ScaffoldMessenger.of(scKey.currentContext).showSnackBar(SnackBar(
  //           content: Text(repository.allMessages.value.wrongEmailAndPassword),
  //         ));
  //       }
  //     }).catchError((e) {
  //       throw e;
  //     });
  //   } catch (e) {
  //     BotToast.showCustomText(toastBuilder: (_) => Text(e.toString()));
  //   } finally {
  //     BotToast.closeAllLoading();
  //   }
  // }
}
