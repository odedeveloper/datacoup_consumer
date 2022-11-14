import 'dart:developer';

import 'package:datacoup/export.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewWidget extends StatelessWidget {
  final String? url;
  final bool? showAppbar;
  final bool? showFav;
  final String? title;
  final Item? data;
  WebViewWidget(
      {super.key,
      this.showFav = true,
      this.title,
      this.showAppbar = false,
      this.url,
      this.data});

  final newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    // InAppWebViewController? webViewController;
    return Scaffold(
      appBar: showAppbar!
          ? AppBar(
              title: title != null ? Text(title!) : null,
            )
          : null,
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.tryParse(url!)),
        initialOptions:
            InAppWebViewGroupOptions(crossPlatform: InAppWebViewOptions()),
        onWebViewCreated: (InAppWebViewController controller) {
          // webViewController = controller;
        },
        onLoadStart: (controller, url) {
          log('page loaded on => $url');
        },
      ),
      floatingActionButton: showFav!
          ? Obx(
              () => FloatingActionButton(
                onPressed: () {
                  newsController.likeAndUnlikeNews(
                    data: data,
                    isLiked: newsController.allFavouriteNewsItem
                            .any((element) => element.newsId == data!.newsId)
                        ? false
                        : true,
                  );
                },
                child: FaIcon(
                  newsController.allFavouriteNewsItem
                          .any((element) => element.newsId == data!.newsId)
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  color: newsController.allFavouriteNewsItem
                          .any((element) => element.newsId == data!.newsId)
                      ? redOpacityColor
                      : Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}
