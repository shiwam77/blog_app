//@dart=2.9

import 'package:flutter/material.dart';
import 'package:incite/pages/ads.dart';
import 'package:incite/pages/auth.dart';
import 'package:incite/pages/category_post.dart';
import 'package:incite/pages/home_page.dart';
import 'package:incite/pages/home_page_clone_1.dart';
import 'package:incite/pages/latest_post.dart';
import 'package:incite/pages/load_swipeable.dart';
import 'package:incite/pages/read_blog.dart';
import 'package:incite/pages/saved_post.dart';
import 'package:incite/pages/search_page.dart';
import 'package:incite/pages/user_profile.dart';

import 'models/blog_model.dart';
import 'pages/language_selection.dart';
import 'pages/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print("screen name ${settings.name}");
    switch (settings.name) {
      case '/SplashScreen':
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case '/LanguageSelection':
        return MaterialPageRoute(
          builder: (context) => LanguageSelection(
            isInHomePage: args,
          ),
        );
      case '/MainPage':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/HomeClonePage':
        return MaterialPageRoute(builder: (context) => HomeClonePage());
      case '/ReadBlog':
        final args = settings.arguments as Blog;

        return MaterialPageRoute(builder: (context) => ReadBlog(args));
      case '/AuthPage':
        return MaterialPageRoute(builder: (context) => AuthPage());
      case '/LoadSwipePage':
        return MaterialPageRoute(builder: (context) => LoadSwipePage());
      case '/UserProfile':
        final args = settings.arguments as bool;

        return MaterialPageRoute(builder: (context) => UserProfile(args));
      case '/SearchPage':
        return MaterialPageRoute(builder: (context) => SearchPage());
      case '/LatestPage':
        return MaterialPageRoute(builder: (context) => LatestPage());
      case '/SavedPage':
        return MaterialPageRoute(builder: (context) => SavedPage());
      case '/CategoryPostPage':
        final args = settings.arguments as int;

        return MaterialPageRoute(builder: (context) => CategoryPostPage(args));
      // case '/ReadBlogSwipe':
      //   final args = settings.arguments as Blog;
      //
      //   return MaterialPageRoute(builder: (context) => ExampleHomePage(args));
      case '/Ads':
        return MaterialPageRoute(builder: (context) => AdsPage());
      default:
        //? in case no route has been specified [for safety]
        return MaterialPageRoute(builder: (context) => AuthPage());
    }
  }
}
