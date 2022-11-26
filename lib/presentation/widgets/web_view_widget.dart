import 'dart:developer';

import 'package:datacoup/export.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewWidget extends StatefulWidget {
  final String? url;
  final bool? showAppbar;
  final bool? showFav;
  final String? title;
  final Item? data;
  const WebViewWidget(
      {super.key,
      this.showFav = true,
      this.title,
      this.showAppbar = false,
      this.url,
      this.data});

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final newsController = Get.find<NewsController>();

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // InAppWebViewController? webViewController;
    return Scaffold(
      appBar: widget.showAppbar!
          ? AppBar(
              centerTitle: true,
              title: widget.title != null
                  ? Text(
                      widget.title!,
                      style: themeTextStyle(
                        context: context,
                        fsize: klargeFont(context),
                        fweight: FontWeight.bold,
                      ),
                    )
                  : null,
              actions: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        var isPortrait = MediaQuery.of(context).orientation ==
                            Orientation.portrait;
                        if (isPortrait) {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeLeft,
                          ]);
                        } else {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown
                          ]);
                        }
                      },
                      icon: const Icon(
                        Icons.screen_rotation_outlined,
                      ),
                    )),
              ],
            )
          : null,
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.tryParse(widget.url!)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            javaScriptEnabled: true,
            javaScriptCanOpenWindowsAutomatically: true,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          // webViewController = controller;
        },
        onLoadStart: (controller, url) {
          log('page loaded on => $url');
        },
      ),
      floatingActionButton: widget.showFav!
          ? Obx(
              () => FloatingActionButton(
                onPressed: () {
                  newsController.likeAndUnlikeNews(
                    data: widget.data,
                    isLiked: newsController.allFavouriteNewsItem.any(
                            (element) => element.newsId == widget.data!.newsId)
                        ? false
                        : true,
                  );
                },
                child: FaIcon(
                  newsController.allFavouriteNewsItem.any(
                          (element) => element.newsId == widget.data!.newsId)
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  color: newsController.allFavouriteNewsItem.any(
                          (element) => element.newsId == widget.data!.newsId)
                      ? redOpacityColor
                      : Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}
