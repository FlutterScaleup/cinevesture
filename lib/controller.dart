import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WebViewController extends GetxController {
  RxBool isLogin = false.obs;
  @override
  void onInit() {
    // webviewController.loadUrl(urlRequest: URLRequest(url: Uri.parse('http://devtest1.cinevesture.com/home')));
    super.onInit();
  }

  late InAppWebViewController webviewController;
}
