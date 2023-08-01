//@dart=2.9

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:incite/controllers/user_controller.dart';
import 'package:incite/repository/user_repository.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appColors.dart';
import '../providers/app_provider.dart';

class LanguageSelection extends StatefulWidget {
  bool isInHomePage;
  LanguageSelection({this.isInHomePage = false});
  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  bool _userLog = false;
  UserController userController = UserController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getAllAvialbleLanguages();
  }

  getAllAvialbleLanguages() async {
    print("allLanguages ${allLanguages.length}");
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      color: Colors.grey,
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/img/app_icon.png",
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                "Choose your language",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "भाषा जा चयन कीजिये",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      childAspectRatio: 3.3),
                  itemCount: allLanguages.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        AppProvider provider =
                            Provider.of<AppProvider>(context, listen: false);
                        languageCode.value = allLanguages[index];
                        print(languageCode.value);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("defalut_language",
                            json.encode(languageCode.value.toJson()));
                        prefs.setString("local_data",
                            json.encode(allMessages.value.toJson()));
                        userController.getLanguageFromServer().then((value) {
                          if (!widget.isInHomePage) {
                            Navigator.pushNamedAndRemoveUntil(context,
                                '/AuthPage', (Route route) => route.isFirst);
                            setState(() {
                              loading = false;
                            });
                          } else {
                            if (currentUser.value.name != null) {
                              userController.updateLanguage();
                            }
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context, false);
                            Navigator.pop(context, true);
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10,
                            left: index % 2 == 0 ? 30 : 5,
                            right: index % 2 != 0 ? 30 : 5),
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[400],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            allLanguages[index].name,
                            style: TextStyle(
                              color: appMainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
