//@dart=2.9

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:incite/data/blog_list_holder.dart';
import 'package:incite/pages/read_blog.dart';
import 'package:incite/repository/user_repository.dart';
import 'package:preload_page_view/preload_page_view.dart';

const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

class SwipeablePage extends StatefulWidget {
  final int index;
  SwipeablePage(this.index);

  @override
  _SwipeablePageState createState() => _SwipeablePageState();
}

class _SwipeablePageState extends State<SwipeablePage> {
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  static const rewardedInterstitialButtonText = 'RewardedInterstitialAd';
  static const interstitialButtonText = 'InterstitialAd';
  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  RewardedInterstitialAd _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;

//  PageController pageController;
  PreloadPageController pageController;
  double height, width;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    _createRewardedInterstitialAd();
    _createInterstitialAd();
    // pageController = PageController(initialPage: widget.index);
    pageController = PreloadPageController(initialPage: widget.index);
    currentPage = widget.index;
    pageController.addListener(listener);
    if (blogListHolder.getList().length == 1) {
      Fluttertoast.showToast(msg: "Last News");
    }
  }

  listener() {
    if (pageController.position.atEdge) {
      if (pageController.position.pixels == 0) {
        // Fluttertoast.showToast(msg: "T");
      } else {
        Fluttertoast.showToast(msg: "Last News");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      color: HexColor("#323232"),
      child: PreloadPageView.builder(
        itemBuilder: (ctx, index) {
          if (blogListHolder.getList()[index].type == "ads") {
            return Scaffold();
          } else {
            return ReadBlog(blogListHolder.getList()[index]);
          }
        },
        itemCount: blogListHolder.getList().length,
        scrollDirection: Axis.vertical,
        preloadPagesCount: 0,
        // reverse: true,
        //allowImplicitScrolling: false,
        physics: CustomPageViewScrollPhysics(),
        controller: pageController,
        pageSnapping: true,
        onPageChanged: (value) {
          print("page change");
          currentUser.value.isNewUser = false;
          blogListHolder.setIndex(value);
          // if ((value + 1) % 5 == 0 &&
          //     blogListHolder.getList()[value].type != "ads") {
          //   _showInterstitialAd();
          // }
          if (blogListHolder.getList()[value].type == "ads") {
            setState(() {
              if (currentPage > value) {
                if (value != 0) {
                  pageController.jumpToPage(
                    value = value - 1,
                  );
                }
              } else {
                if (value != blogListHolder.getList().length) {
                  pageController.jumpToPage(
                    value = value + 1,
                  );
                }
              }
            });
            _showRewardedInterstitialAd();
          }
          currentPage = value;
        },
      ),
    );
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd.show();
    _interstitialAd = null;
  }

  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5354046379'
            : 'ca-app-pub-3940256099942544/6978759866',
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            print('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedInterstitialAd();
            }
          },
        ));
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
    );

    _rewardedInterstitialAd.setImmersiveMode(true);
    _rewardedInterstitialAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });

    _rewardedInterstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    pageController.removeListener(listener);
    pageController.dispose();
    _rewardedInterstitialAd?.dispose();
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 100,
        damping: 1,
      );
}
