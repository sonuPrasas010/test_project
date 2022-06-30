import 'package:facebook_audience_network/ad/ad_interstitial.dart';

class FacebookIntres {
  static bool isLoaded = false;
  static void load() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {
          isLoaded = true;
        } else {
          isLoaded = false;
          load();
        }
      },
    );
  }

  static void show() {
    if (isLoaded) FacebookInterstitialAd.showInterstitialAd();
  }

  static void loadAndShow() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
      listener: (result, value) {
        print("$result-> $value");
        if (result == InterstitialAdResult.LOADED)
          FacebookInterstitialAd.showInterstitialAd();
      },
    );
  }
}
