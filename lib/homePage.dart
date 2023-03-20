import 'package:cinevesture/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.url});
  String url;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late WebViewXController webviewController;
  final webViewControllergetx = Get.find<WebViewController>();
  PullToRefreshController pullToRefreshController = PullToRefreshController();
  bool willPop = false;
  String oldUrl = '';

  Future<bool> _onWillPop() async {
    webViewControllergetx.webviewController.goBack();
    if (willPop == true) {
      alertDialog(context);
    }

    return false;
  }

  alertDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter stateSetter) {
            // _setState = stateSetter;
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                    // width: MediaQuery.of(context).size.width / 1.2,
                    padding: const EdgeInsets.only(
                        top: 14, left: 24, bottom: 34, right: 24),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          const Text('Are You Sure?'),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Do you want to exit the app',
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xff33084C),
                                    ),
                                    borderRadius: const BorderRadius.horizontal(
                                        left: Radius.circular(4),
                                        right: Radius.circular(
                                            4)), /*color: AppColors().orange*/
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text('Cancel'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  SystemNavigator.pop();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(4),
                                          right: Radius.circular(4)),
                                      color: Color(0xff33084C)),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Yes",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                        ])));
          });
        });
  }

  @override
  void initState() {
    oldUrl = widget.url;
    print('cinevesture:$oldUrl');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: InAppWebView(
              onConsoleMessage: (controller, msg) {

                print('');
              },
              onLoadStart: (controller, url) {
                 //print('here the url $url');
                if (url.toString().contains('/login')) {
                  webViewControllergetx.isLogin.value = true;
                } else {
                  webViewControllergetx.isLogin.value = !true;
                }
                print('old url:$oldUrl\nnew url:${url.toString()}');
                 if(oldUrl != url.toString()){
                oldUrl = url.toString();
                if(!oldUrl.contains('src=app')) {
                  if(oldUrl.contains('?')){
                    oldUrl = '$oldUrl&src=app';
                     } else {
                    oldUrl = '$oldUrl?src=app';
                  }
                 // Fluttertoast.showToast(msg: oldUrl);
                  controller.loadUrl(urlRequest: URLRequest(url: Uri.parse(oldUrl)));
                }
                }
              },
              onLoadStop: (controller, url) {
                oldUrl = url.toString();
                if (url.toString() == widget.url) {
                  willPop = true;
                } else {
                  willPop = false;
                }
              },
              onDownloadStartRequest: (controller, req) async {
                await Permission.storage.request();
                await InternetFile.get(req.url.toString(),
                    storage: InternetFileStorageIO(),
                    storageAdditional: InternetFileStorageIO().additional(
                        filename:
                            '${(await getExternalStorageDirectory())!.path}/${req.url.toString().split('/')[req.url.toString().split('/').length - 1]}',
                        location: ''),
                    progress: (recLen, contLen) {});
                Fluttertoast.showToast(msg: "Downloaded successfully");
              },
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      userAgent: "Random", useOnDownloadStart: true),
                  android: AndroidInAppWebViewOptions(
                      allowFileAccess: true,
                      allowContentAccess: true,
                      hardwareAcceleration: true)),
              onWebViewCreated: (controller) =>
                  webViewControllergetx.webviewController = controller,
              initialUrlRequest:
                  URLRequest(url: Uri.parse(Uri.encodeFull(widget.url))),
              pullToRefreshController: pullToRefreshController),
        ),
      ),
    );
  }
}
