// import 'dart:io';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class MyInterstitialAd {
//   static InterstitialAd? _interstitialAd;
//   static bool _interstitialReady = false;

//   static const AdRequest request =  AdRequest(
//       nonPersonalizedAds: false,
//       keywords: [
//         "Torrent, Movie, Entertainment, Social Media, Subtitle, Free, Download, Video"
//       ]);

//   static Future<void> createInterstitialAd() async{
//     InterstitialAd.load(
//       /*ca-app-pub-7597097971506812/1567143593*/
//       adUnitId:"ca-app-pub-7099667382343248/1845042827",
//       request: request,
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (InterstitialAd ad) {
//           _interstitialReady = true;
//           print('$ad loaded');
//           _interstitialAd = ad;
//           _interstitialAd?.setImmersiveMode(true);
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           print('InterstitialAd failed to load: $error.');
//           _interstitialReady = false;
//           createInterstitialAd();
//         },
//       ),
//     );
//   }

//   static Future<void> showAd() async {
//     if (!_interstitialReady) return;

//     _interstitialAd?.fullScreenContentCallback =
//         FullScreenContentCallback(onAdShowedFullScreenContent: (ad) {
//       print('InterstitialAd showed full screen content.');
//       MyInterstitialAd.createInterstitialAd();
//     }, onAdFailedToShowFullScreenContent: (ad, err) {
//       print("InterstitialAd failed to show full screen content: $err");
//       MyInterstitialAd.createInterstitialAd();
//     }, onAdWillDismissFullScreenContent: (ad) {
//       print("InterstitialAd will dismiss full screen content");
//     }, onAdImpression: (ad) {
//       print("InterstitialAd impression");
//     }, onAdDismissedFullScreenContent: (ad) {
//       print("InterstitialAd dismissed full screen content");
//     });
//     _interstitialAd?.show();
//     _interstitialReady = false;
//     _interstitialAd = null;
//     MyInterstitialAd.createInterstitialAd();
//   }
// }
