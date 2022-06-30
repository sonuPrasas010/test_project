import 'package:get/get.dart';

import '../../model/services/DataFetcher.dart';

class YTSDetailsController extends GetxController {
  final String url;

  YTSDetailsController(this.url);

  final DataFetcher dataFetcher = DataFetcher();
  Map data = <Map, dynamic>{}.obs;
  RxBool isLoading = true.obs;

  @override
  void dispose() {
    print(
      "Dispoesed"
    );
    super.dispose();

  }



  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    try {
      data = await dataFetcher.fetchRawData(url);
      print(data);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
