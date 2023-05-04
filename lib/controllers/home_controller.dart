//@dart=2.9

import 'package:flutter/material.dart';
import 'package:incite/repository/home_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/blog_model.dart';

class HomeController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<IgBlog> category = [];

  HomeController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future listenForCategory() async {
    final Stream<IgBlog> stream = await getCategory();
    stream.listen((IgBlog _category) {
      print(_category.data.toString());

      category.add(_category);
    });
  }
}
