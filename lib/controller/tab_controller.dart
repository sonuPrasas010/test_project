import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// 
class MyTabController extends GetxController {
  PageController pageController = PageController();
 final RxInt _selectedIndex = 0.obs;
  int get getSelectedIndex => _selectedIndex();
  RxBool isBannerAdLoaded = true.obs;
  // BannerAd bannerAd = BannerAd(
  //   size: AdSize.banner,
  //   /*ca-app-pub-7099667382343248/8624141960*/
  //   adUnitId: "ca-app-pub-7099667382343248/8624141960",
  //   /*Platform.isAndroid
  //         ? 'ca-app-pub-3940256099942544/6300978111'
  //         : 'ca-app-pub-3940256099942544/2934735716',*/
  //   listener: BannerAdListener(
  //     onAdLoaded: (Ad ad) {
  //       print('$BannerAd loaded.');
  //     },
  //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //       print('$BannerAd failedToLoad: $error');
  //       ad.dispose();
  //     },
  //     onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
  //     onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
  //   ),
  //   request: const AdRequest(),
  // )..load().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    pageController.addListener(() {});
  }

  void setSelectedIndex(int i) {
    _selectedIndex.value = i;
  }
}
