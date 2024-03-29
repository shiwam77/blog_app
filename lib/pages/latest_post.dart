//@dart=2.9

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:incite/data/blog_list_holder.dart';
import 'package:incite/elements/bottom_card_item.dart';
import 'package:incite/elements/drawer_builder.dart';
import 'package:incite/repository/user_repository.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../app_theme.dart';
// import 'package:incite/models/blog_category.dart';
import '../models/blog_category.dart';

//* <----------- Search Blog Page -------------->

class LatestPage extends StatefulWidget {
  @override
  _LatestPageState createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage> {
  TextEditingController searchController;
  List<Blog> blogList = [];
  bool _isLoading = false;
  bool _isFound = true;
  var height, width;
  @override
  initState() {
    currentUser.value.isPageHome = false;
    getLatestBlog();
    super.initState();
    searchController = TextEditingController();
  }

  Future getLatestBlog() async {
    _isLoading = true;
    var url = "https://incite.technofox.co.in/api/blog-all-list";
    var result = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'userData': currentUser.value.id,
        "lang-code": languageCode.value?.language ?? null
      },
    );
    Map data = json.decode(result.body);
    final list = FilteredBlog.fromJson(data).data.toList();

    setState(() {
      blogListHolder.clearList();
      blogListHolder.setList(list);
      blogList = list;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return LoadingOverlay(
      isLoading: _isLoading,
      color: Colors.grey,
      child: Scaffold(
          drawer: DrawerBuilder(),
          onDrawerChanged: (value) {
            if (!value) {
              setState(() {});
            }
          },
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            automaticallyImplyLeading: false,
            title: LayoutBuilder(builder: (contextname, constraints) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(contextname).openDrawer();
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/img/loveoman.png",
                      width: 0.3 * width,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 23.0),
                      child: Image.asset(
                        "assets/img/menu.png",
                        fit: BoxFit.none,
                        color: appThemeModel.value.isDarkModeEnabled.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Spacer(),
                    currentUser.value.name != null
                        ? GestureDetector(
                            child: Image.asset(
                              "assets/img/search.png",
                              width: 0.06 * width,
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/SearchPage');
                            },
                          )
                        : Container(),
                    SizedBox(
                      width: 0.044 * constraints.maxWidth,
                    ),
                    Container(
                      width: 0.08 * constraints.maxWidth,
                      height: 0.08 * constraints.maxWidth,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/UserProfile', arguments: true);
                        },
                        child: Hero(
                          tag: 'photo',
                          child: CircleAvatar(
                            backgroundImage: currentUser.value.photo != null &&
                                    currentUser.value.photo != ''
                                ? NetworkImage(currentUser.value.photo)
                                : AssetImage('assets/img/user.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Theme.of(context).cardColor,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                        child: Text(
                          allMessages.value.latestPost,
                          style: Theme.of(context).textTheme.bodyText1.merge(
                                TextStyle(
                                    color: appThemeModel
                                            .value.isDarkModeEnabled.value
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w800),
                              ),
                        ),
                      ),
                    ),
                    Container(
                      child: _isFound
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                children: blogList
                                    .map((e) => SearchCard(
                                          e,
                                          blogList.indexOf(e),
                                          blogList,
                                          isTrending: false,
                                        ))
                                    .toList(),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                children: [
                                  Text(
                                    allMessages.value
                                        .noResultsFoundMatchingWithYourKeyword,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .merge(
                                          TextStyle(
                                              color: appThemeModel.value
                                                      .isDarkModeEnabled.value
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
