// ignore: file_names
import 'package:cinevesture/controller.dart';
import 'package:cinevesture/homePage.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  WebViewController webViewControllergetx = Get.put(WebViewController());
  List navTabs = [
    'http://devtest1.cinevesture.com/home',
    'http://devtest1.cinevesture.com/industiry-guide/profile-show',
    'http://devtest1.cinevesture.com/job/search',
    'http://devtest1.cinevesture.com/user/profile-private-show'
  ];
  var _SelectedTab = 'http://devtest1.cinevesture.com/home';
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: MyHomePage(
        url: GetPlatform.isIOS
            ? _SelectedTab.toString()
                .replaceAll('http://devtest1', 'https://app')
            : _SelectedTab.toString(),
      ),
      bottomNavigationBar: Obx(
        () => webViewControllergetx.isLogin.value
            ? const SizedBox()
            : DotNavigationBar(
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff33084C).withOpacity(.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 0))
                ],
                enableFloatingNavBar: !false,
                currentIndex: index,
                onTap: (v) {
                  index = v;
                  _SelectedTab = navTabs[v];
                  setState(() {
                    webViewControllergetx.webviewController.loadUrl(
                        urlRequest: URLRequest(
                            url: Uri.parse(GetPlatform.isIOS
                                ? _SelectedTab.toString().replaceAll(
                                    'http://devtest1', 'https://app')
                                : _SelectedTab.toString())));
                  });
                },
                items: [
                  /// Home
                  DotNavigationBarItem(
                    icon: const Icon(Icons.home),
                    selectedColor: const Color(0xff33084C),
                  ),

                  /// Likes
                  DotNavigationBarItem(
                    icon: const Icon(Icons.handshake_outlined),
                    selectedColor: const Color(0xff33084C),
                  ),

                  /// Search
                  DotNavigationBarItem(
                    icon: const Icon(Icons.search),
                    selectedColor: const Color(0xff33084C),
                  ),

                  /// Profile
                  DotNavigationBarItem(
                    icon: const Icon(Icons.person),
                    selectedColor: const Color(0xff33084C),
                  ),
                ],
              ),
      ),
    );
  }
}
