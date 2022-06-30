import 'dart:io';

import 'package:c_movies/home.dart';
import 'package:c_movies/searchList.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'cmoviesList.dart';
import 'controller/tab_controller.dart';
import 'model/ads/InterstitialAd.dart';
import 'torrentList.dart';
// import 'package:native_admob_flutter/native_admob_flutter.dart' as nv;

const double borderRadius = 25.0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // MyInterstitialAd.createInterstitialAd();

  // await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tor Movie',
      theme: ThemeData(
        fontFamily: "montserrat",

        primarySwatch: Colors.blue,
        backgroundColor: const Color(0xFF111820),
        scaffoldBackgroundColor: const Color(0xFF111820),

        primaryColor: const Color(
          0xFF111820,
        ),
        // primaryColorLight: const Color(0xFFBDBDBD),
        // buttonTheme: ButtonThemeData(buttonColor: Color(0xFFC82333)),
        // elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle())
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final MyTabController tabController = MyTabController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            // bottomNavigationBar: tabController.isBannerAdLoaded.value
            //     ? Container(
            //         color: Colors.transparent,
            //         height: tabController.bannerAd.size.height.toDouble(),
            //         width: tabController.bannerAd.size.width.toDouble(),
            //         child: AdWidget(ad: tabController.bannerAd))
            //     : SizedBox(),
            backgroundColor: const Color(0XFF111820),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SafeArea(
                child: SizedBox(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: _menuBar(context),
                      ),
                      Expanded(
                        flex: 2,
                        child: PageView(
                          controller: tabController.pageController, //
                          physics: const ClampingScrollPhysics(),
                          onPageChanged: (int i) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            tabController.setSelectedIndex(i);

                            // setState(() {
                            //   activePageIndex = i;
                            // });
                          },
                          children: <Widget>[
                            // ConstrainedBox(
                            //   constraints: const BoxConstraints.expand(),
                            //   child:

                            Home(),
                            // ),
                            // ConstrainedBox(
                            //   constraints: const BoxConstraints.expand(),
                            //   child:
                            // TorrentList(),
                            // ),

                            // ConstrainedBox(
                            //   constraints: const BoxConstraints.expand(),
                            //   child:
                            CMoviesList("cinema-movies", "Cinema Movies"),
                            // ),

                            // ConstrainedBox(
                            //   constraints: const BoxConstraints.expand(),
                            //   child:
                            CMoviesList("series", "Series"),
                            // ),

                            // const SearchList()
                          ],
                        ),
                      ),
                      // FacebookBannerAd(
                      //   // placementId: "YOUR_PLACEMENT_ID",

                      //   keepAlive: true,
                      //   placementId:
                      //       "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
                      //   bannerSize: BannerSize.STANDARD,
                      //   listener: (result, value) {
                      //     print("Banner Ad: $result -->  $value");
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            // bottomNavigationBar: SizedBox(
            //   width: AdSize.banner.width.toDouble(),
            //   height: AdSize.banner.height.toDouble(),
            //   child: AdWidget(
            //     ad: BannerAd(
            //       size: AdSize.getInlineAdaptiveBannerAdSize(
            //           AdSize.banner.width, AdSize.banner.height),
            //       adUnitId: Platform.isAndroid
            //           ? 'ca-app-pub-3940256099942544/6300978111'
            //           : 'ca-app-pub-3940256099942544/2934735716',
            //       listener: BannerAdListener(
            //         onAdLoaded: (Ad ad) {
            //           print('$BannerAd loaded.');

            //           // changeAdLoadState();
            //         },
            //         onAdFailedToLoad: (Ad ad, LoadAdError error) {
            //           print('$BannerAd failedToLoad: $error');
            //           ad.dispose();
            //         },
            //         onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
            //         onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
            //       ),
            //       request: MyInterstitialAd.request,
            //     )..load(),
            //   ),
            // ),
          ),
        ));
  }

  Widget _menuBar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      // decoration: const BoxDecoration(
      //   color: Color(0XFFE0E0E0),
      //   borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Expanded( child:
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
            onTap: _moviePress,
            // child: Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: EdgeInsets.symmetric(vertical: 15),
            //   alignment: Alignment.center,
            //   decoration: (activePageIndex == 0)
            //       ? const BoxDecoration(
            //           color: Colors.green,
            //           borderRadius:
            //               BorderRadius.all(Radius.circular(borderRadius)),
            //         )
            //       : null,
            child: Text(
              "Home",
              style: (tabController.getSelectedIndex == 0)
                  ? const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)
                  : const TextStyle(
                      color: Color(0xFF7A90AA),
                      fontSize: 12,
                    ),
            ),
          ),
          // ),
          // ),
          // Expanded(child:
          // InkWell(
          //   borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
          //   onTap: () => _onTvShowsPressed(1),
          //   // child: Container(
          //   //   width: MediaQuery.of(context).size.width,
          //   //   padding: EdgeInsets.symmetric(vertical: 15),
          //   //   alignment: Alignment.center,
          //   //   decoration: (activePageIndex == 1)
          //   //       ? const BoxDecoration(
          //   //           color: Colors.green,
          //   //           borderRadius:
          //   //               BorderRadius.all(Radius.circular(borderRadius)),
          //   //         )
          //   //       : null,
          //   child: Text(
          //     "Torrent Movies",
          //     style: (tabController.getSelectedIndex == 1)
          //         ? const TextStyle(
          //             color: Colors.white,
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold)
          //         : const TextStyle(
          //             color: Color(0xFF7A90AA),
          //             fontSize: 12,
          //           ),
          //   ),
          // ),
          // ),
          // ),
          // Expanded(child:
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
            onTap: () => _onTvShowsPressed(1),
            // child: Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: EdgeInsets.symmetric(vertical: 15),
            //   alignment: Alignment.center,
            //   decoration: (activePageIndex == 1)
            //       ? const BoxDecoration(
            //           color: Colors.green,
            //           borderRadius:
            //               BorderRadius.all(Radius.circular(borderRadius)),
            //         )
            //       : null,
            child: Text(
              "Popular",
              style: (tabController.getSelectedIndex == 1)
                  ? const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)
                  : const TextStyle(color: Color(0xFF7A90AA), fontSize: 12),


                  
            ),
          ),
          // ),
          // ),

          // Expanded(child:
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
            onTap: () => _onTvShowsPressed(2),
            // child: Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: EdgeInsets.symmetric(vertical: 15),
            //   alignment: Alignment.center,
            //   decoration: (activePageIndex == 1)
            //       ? const BoxDecoration(
            //           color: Colors.green,
            //           borderRadius:
            //               BorderRadius.all(Radius.circular(borderRadius)),
            //         )
            //       : null,
            child: Text(
              "Tv Shows",
              style: (tabController.getSelectedIndex == 2)
                  ? const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)
                  : const TextStyle(
                      color: Color(0xFF7A90AA),
                      fontSize: 12,
                    ),
            ),
          ),

          GestureDetector(
            onTap: () {
              // _onTvShowsPressed(4);
              Get.to(() => const SearchList());
            },
            child: Icon(
              Icons.search,
              color: (tabController.getSelectedIndex == 3)
                  ? Colors.white
                  : Colors.grey,
            ),
          ),
          // ),
          // ),
        ],
      ),
    );
  }

  void _moviePress() {
    tabController.pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onTvShowsPressed(int index) {
    tabController.pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
