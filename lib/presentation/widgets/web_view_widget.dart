import 'dart:developer';

import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/widgets/back_button.dart';
import 'package:datacoup/presentation/widgets/simple_loader.dart';
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

  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    if (widget.showFav == true) {
      SystemChrome.setPreferredOrientations([]);
    }
    super.initState();
  }

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
              elevation: 0,
              centerTitle: false,
              // backgroundColor: whiteColor,
              leading: CustomBackButton(),
              title:
                  // Row(children: [BackButton()]),

                  widget.title != null
                      ? Text(
                          widget.title!,
                          style: themeTextStyle(
                            context: context,
                            fsize: klargeFont(context),
                            fweight: FontWeight.bold,
                          ),
                        )
                      : null,

              actions: widget.showFav!
                  ? [
                      Obx(
                        () => IconButton(
                          // backgroundColor: blueGreyLight,
                          onPressed: () {
                            newsController.likeAndUnlikeNews(
                              data: widget.data,
                              isLiked: newsController.allFavouriteNewsItem.any(
                                      (element) =>
                                          element.newsId == widget.data!.newsId)
                                  ? false
                                  : true,
                            );
                          },
                          icon: FaIcon(
                            newsController.allFavouriteNewsItem.any((element) =>
                                    element.newsId == widget.data!.newsId)
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: newsController.allFavouriteNewsItem.any(
                                    (element) =>
                                        element.newsId == widget.data!.newsId)
                                ? deepOrangeColor
                                : deepOrangeColor,
                          ),
                        ),
                      )
                    ]
                  : [],
              // actions: [
              //   Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: IconButton(
              //         onPressed: () {
              //           var isPortrait = MediaQuery.of(context).orientation ==
              //               Orientation.portrait;
              //           if (isPortrait) {
              //             SystemChrome.setPreferredOrientations([
              //               DeviceOrientation.landscapeLeft,
              //               DeviceOrientation.landscapeLeft,
              //             ]);
              //           } else {
              //             SystemChrome.setPreferredOrientations([
              //               DeviceOrientation.portraitUp,
              //               DeviceOrientation.portraitDown
              //             ]);
              //           }
              //         },
              //         icon: const Icon(
              //           Icons.screen_rotation_outlined,
              //         ),
              //       )),
              // ],
            )
          : null,
      body: Stack(
        children: [
          InAppWebView(
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
              controller.evaluateJavascript(
                  source:
                      "document.getElementsByTagName('header')[0].style.display = 'none';document.body.style.fontFamily='cursive !important';");
            },
            onLoadStop: (controller, url) {
              controller.evaluateJavascript(
                  source:
                      "document.getElementsByTagName('header')[0].style.display = 'none';document.body.style.fontFamily='cursive !important';document.getElementsByTagName('nav')[0].style.display = 'none';document.getElementsByTagName('nav')[1].style.display = 'none';document.getElementsByTagName('nav')[2].style.display = 'none';document.getElementsByTagName('nav')[3].style.display = 'none'");

              setState(() {
                isLoading = false;
              });
            },
            onLoadError: (controller, url, code, message) {
              setState(() {
                isError = true;
              });
            },
          ),
          isLoading
              ? Container(
                  height: double.infinity,
                  color: Theme.of(context).cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SimpleLoader(),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Loading article",
                        style: themeTextStyle(
                            tColor: Theme.of(context).primaryColor,
                            context: context,
                            fweight: FontWeight.w700),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
          isError
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Theme.of(context).cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetConst.NOT_FOUND,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Not found",
                        style: themeTextStyle(
                            tColor: Theme.of(context).primaryColor,
                            context: context,
                            fweight: FontWeight.w700),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
      // floatingActionButton: widget.showFav!
      //     ? Obx(
      //         () => FloatingActionButton(
      //           backgroundColor: darkBlueGreyColor,
      //           onPressed: () {
      //             newsController.likeAndUnlikeNews(
      //               data: widget.data,
      //               isLiked: newsController.allFavouriteNewsItem.any(
      //                       (element) => element.newsId == widget.data!.newsId)
      //                   ? false
      //                   : true,
      //             );
      //           },
      //           child: FaIcon(
      //             newsController.allFavouriteNewsItem.any(
      //                     (element) => element.newsId == widget.data!.newsId)
      //                 ? FontAwesomeIcons.solidHeart
      //                 : FontAwesomeIcons.heart,
      //             color: newsController.allFavouriteNewsItem.any(
      //                     (element) => element.newsId == widget.data!.newsId)
      //                 ? deepOrangeColor
      //                 : Colors.white,
      //           ),
      //         ),
      //       )
      //     : null,
    );
  }
}
