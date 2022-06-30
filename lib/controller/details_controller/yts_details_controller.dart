 
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/services/DataFetcher.dart';

class YTSDetailsController extends GetxController {
  final String url;

  YTSDetailsController(this.url);

  final DataFetcher dataFetcher = DataFetcher();
  Map data = <String, dynamic>{}.obs;
  RxBool isLoading = true.obs;
  // RxBool nativeAdIsLoaded = false.obs;

  @override
  void onReady() {
    super.onReady();
  }

  // final NativeAd nativeAd = NativeAd(
  //   adUnitId: Platform.isAndroid
  //       ? 'ca-app-pub-3940256099942544/2247696110'
  //       : 'ca-app-pub-3940256099942544/3986624511',
  //   request: const AdRequest(),
  //   factoryId: 'listTile',
  //   listener: NativeAdListener(
  //     onAdLoaded: (Ad ad) {},
  //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //       print('$NativeAd failedToLoad: $error');
  //       ad.dispose();
  //     },
  //     onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
  //     onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
  //   ),
  // )..load();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    isLoading(true);
    try {
      data = await dataFetcher.fetchRawData(url);
      print(data);
    } catch (e) {
      print(e);
      debugPrint(e.runtimeType.toString());
    } finally {
      isLoading(false);
    }
  }
}
