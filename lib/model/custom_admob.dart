// import 'dart:io';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class CustomAdmob {
//   static const AdRequest request = AdRequest(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     nonPersonalizedAds: true,
//   );

//   static InterstitialAd? interstitialAd;

//   static void createInterstitialAd() {
//     InterstitialAd.load(
//       adUnitId: Platform.isAndroid
//           ? 'ca-app-pub-3940256099942544/1033173712'
//           : 'ca-app-pub-3940256099942544/4411468910',
//       request: request,

//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (InterstitialAd ad) {
//           print('$ad loaded');
//           interstitialAd = ad;
          

//           interstitialAd!.setImmersiveMode(true);
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           print('InterstitialAd failed to load: $error.');
//           interstitialAd = null;
//           createInterstitialAd();
//         },
//       ),
//     );
//   }

//   static void showInterstitialAd() {
//     if (interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         createInterstitialAd();
//       },
//     );
//     interstitialAd!.show();
//     interstitialAd = null;
//   }

//   dynamic loadNativeAd() {
//     NativeAd? nativeAd;
//     bool isAdLoaded = false;

//     nativeAd = NativeAd(
//       adUnitId: Platform.isAndroid
//           ? 'ca-app-pub-3940256099942544/2247696110'
//           : 'ca-app-pub-3940256099942544/3986624511',
//       request: AdRequest(),
//       factoryId: 'adFactoryExample',
//       listener: NativeAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$NativeAd loaded.');
//           isAdLoaded = true;
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$NativeAd failedToLoad: $error');
//           ad.dispose();
//           isAdLoaded = false;
//         },
//         // onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
//         // onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
//       ),
//     )..load();

//     if(isAdLoaded)
//       return nativeAd;
//     else
//       return false;
//   }
// }
