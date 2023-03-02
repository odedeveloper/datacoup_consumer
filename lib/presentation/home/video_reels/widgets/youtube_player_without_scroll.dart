import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/video_reels/widgets/youtube_player_widget.dart';
import 'package:datacoup/presentation/home/video_reels/video_reels_controller.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerWithoutScroll extends StatefulWidget {
  const YoutubePlayerWithoutScroll({super.key, this.videoDetail});
  final Item? videoDetail;

  @override
  State<YoutubePlayerWithoutScroll> createState() =>
      _YoutubePlayerWithoutScrollState();
}

class _YoutubePlayerWithoutScrollState
    extends State<YoutubePlayerWithoutScroll> {
  final newsController = Get.find<NewsController>();
  @override
  final vrontroller = Get.put(VideoReelsController());
  final vrController = Get.find<VideoReelsController>();
  YoutubePlayerController? controller;
  YoutubePlayer? ytController;
  var player = const YoutubePlayer();

  void initState() {
    SystemChrome.setPreferredOrientations([]);
    controller = YoutubePlayerController(
        params: YoutubePlayerParams(
            showVideoAnnotations: false, loop: true, playsInline: false))
      ..onInit = () {
        controller?.loadVideoById(
          videoId: widget.videoDetail!.content!.link!
              .replaceAll("https://www.youtube.com/watch?v=", "")
              .replaceAll("https://m.youtube.com/watch?v=", ""),
        );
      };

    controller!.listen((event) {
      if (event.playerState == PlayerState.playing) {
        vrController.isVideoPlaying(true);
      } else {
        vrController.isVideoPlaying(false);
      }
    });
    super.initState();
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    controller!.close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            body: SizedBox(
              height: height(context),
              child: Stack(children: [
                YoutuberPlayerWidget(
                  videoDetail: widget.videoDetail,
                ),
                // Positioned(
                //       left: 10.0,
                //       bottom: 190.0,
                //       child: textTile(
                //         context: context,
                //         data: widget.videoDetail!.content!.creator!,
                //       ),
                //     ),
                //     Positioned(
                //       left: 10.0,
                //       bottom: 155.0,
                //       child: textTile(
                //         context: context,
                //         data: timeAgo(widget.videoDetail!.timeStamp!),
                //       ),
                //     ),
                //     Positioned(
                //       left: 10.0,
                //       bottom: 120.0,
                //       child: textTile(
                //         context: context,
                //         data: widget.videoDetail!.newsType,
                //       ),
                //     ),
                //     // Container(
                //     //   height: double.infinity,
                //     //   width: double.infinity,
                //     //   color: Colors.transparent,
                //     // ),
                //     Positioned(
                //       right: 20.0,
                //       bottom: 210,
                //       child: Obx(
                //         () => InkWell(
                //           onTap: () {
                //             newsController.likeAndUnlikeNews(
                //               data: widget.videoDetail,
                //               isLiked: newsController.allFavouriteNewsItem.any(
                //                       (element) =>
                //                           element.newsId ==
                //                           widget.videoDetail!.newsId)
                //                   ? false
                //                   : true,
                //             );
                //           },
                //           child: FaIcon(
                //             newsController.allFavouriteNewsItem.any((element) =>
                //                     element.newsId == widget.videoDetail!.newsId)
                //                 ? FontAwesomeIcons.solidHeart
                //                 : FontAwesomeIcons.heart,
                //             color: newsController.allFavouriteNewsItem.any(
                //                     (element) =>
                //                         element.newsId ==
                //                         widget.videoDetail!.newsId)
                //                 ? redOpacityColor
                //                 : Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //     Positioned(
                //       right: 10.0,
                //       bottom: 150,
                //       child: IconButton(
                //         onPressed: () {
                //           controller!.toggleFullScreen();
                //         },
                //         icon: const FaIcon(
                //           FontAwesomeIcons.expand,
                //           color: deepOrangeColor,
                //         ),
                //       ),
                //     ),
                //     Align(
                //       alignment: Alignment.bottomCenter,
                //       child: Obx(
                //         () => IconButton(
                //           onPressed: () {
                //             if (vrController.isVideoPlaying.value == true) {
                //               controller!.pauseVideo();
                //             } else {
                //               controller!.playVideo();
                //             }
                //           },
                //           icon: FaIcon(
                //             vrController.isVideoPlaying.value
                //                 ? FontAwesomeIcons.pause
                //                 : FontAwesomeIcons.play,
                //             color: deepOrangeColor,
                //           ),
                //         ),
                //       ),
                //     ),
                OrientationBuilder(builder: (context, orientation) {
                  return orientation == Orientation.portrait
                      ? Container(
                          height: 100,
                          color: blackColor,
                        )
                      : Container();
                }),
                Positioned(
                    left: 0,
                    top: 10.0,
                    child: BackButton(
                      color: deepOrangeColor,
                    )),
                OrientationBuilder(builder: (context, orientation) {
                  return orientation == Orientation.portrait
                      ? Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 90),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),
                              textTile(
                                context: context,
                                data: widget.videoDetail!.content!.creator!,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              textTile(
                                context: context,
                                data: timeAgo(widget.videoDetail!.timeStamp!),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              textTile(
                                context: context,
                                data: widget.videoDetail!.newsType!
                                    .split("_")
                                    .join(" "),
                              ),
                            ],
                          ),
                        )
                      : Container();
                }),

                // Medi ?
                // Positioned(
                //   left: 10.0,
                //   bottom: 155.0,
                //   child: textTile(
                //     context: context,
                //     data: timeAgo(widget.videoDetail!.timeStamp!),
                //   ),
                // ),
                // Positioned(
                //   left: 10.0,
                //   bottom: 120.0,
                //   child: textTile(
                //     context: context,
                //     data:
                //         widget.videoDetail!.newsType!.split("_").join(" "),
                //   ),
                // ),
                // Container(
                //   height: double.infinity,
                //   width: double.infinity,
                //   color: Colors.transparent,
                // ),
                Positioned(
                    right: 20.0,
                    bottom: 150,
                    child: OrientationBuilder(builder: (context, orientation) {
                      return orientation == Orientation.portrait
                          ? Obx(
                              () => InkWell(
                                onTap: () {
                                  newsController.likeAndUnlikeNews(
                                    data: widget.videoDetail!,
                                    isLiked: newsController.allFavouriteNewsItem
                                            .any((element) =>
                                                element.newsId ==
                                                widget.videoDetail!.newsId)
                                        ? false
                                        : true,
                                  );
                                },
                                child: FaIcon(
                                  newsController.allFavouriteNewsItem.any(
                                          (element) =>
                                              element.newsId ==
                                              widget.videoDetail!.newsId)
                                      ? FontAwesomeIcons.solidHeart
                                      : FontAwesomeIcons.heart,
                                  color: newsController.allFavouriteNewsItem
                                          .any((element) =>
                                              element.newsId ==
                                              widget.videoDetail!.newsId)
                                      ? deepOrangeColor
                                      : Colors.white,
                                ),
                              ),
                            )
                          : Container();
                    })),
              ]),
            )));
  }
}




// import 'package:datacoup/export.dart';
// import 'package:datacoup/presentation/home/video_reels/video_reels_controller.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// class YoutubePlayerWithoutScroll extends StatefulWidget {
//   const YoutubePlayerWithoutScroll({super.key, this.videoDetail});
//   final Item? videoDetail;

//   @override
//   State<YoutubePlayerWithoutScroll> createState() => _YoutuberPlayerWidgetState();
// }

// class _YoutuberPlayerWidgetState extends State<YoutubePlayerWithoutScroll> {
//   final vrontroller = Get.put(VideoReelsController());

//   final vrController = Get.find<VideoReelsController>();

//   final newsController = Get.find<NewsController>();

//   YoutubePlayerController? controller;
//   YoutubePlayer? ytController;
//   var player = const YoutubePlayer();
//   @override
//   void initState() {
//     SystemChrome.setPreferredOrientations([]);
//     controller = YoutubePlayerController(
//         params: YoutubePlayerParams(
//             showControls: true, showFullscreenButton: true, showVideoAnnotations: false, loop: true, playsInline: false))
//       ..onInit = () {
//         controller?.loadVideoById(
//           videoId: widget.videoDetail!.content!.link!
//               .replaceAll("https://www.youtube.com/watch?v=", "")
//               .replaceAll("https://m.youtube.com/watch?v=", ""),
//         );
//       };

//     controller!.listen((event) {
//       if (event.playerState == PlayerState.playing) {
//         vrController.isVideoPlaying(true);
//       } else {
//         vrController.isVideoPlaying(false);
//       }
//     });
//     super.initState();
//   }

//   String timeAgo(DateTime d) {
//     Duration diff = DateTime.now().difference(d);
//     if (diff.inDays > 365) {
//       return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
//     }
//     if (diff.inDays > 30) {
//       return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
//     }
//     if (diff.inDays > 7) {
//       return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
//     }
//     if (diff.inDays > 0) {
//       return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
//     }
//     if (diff.inHours > 0) {
//       return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
//     }
//     if (diff.inMinutes > 0) {
//       return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
//     }
//     return "just now";
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//     controller!.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerScaffold(
//       backgroundColor: Colors.black,
//       autoFullScreen: true,
//       // defaultOrientations: const [
//       //   DeviceOrientation.landscapeLeft,
//       //   DeviceOrientation.landscapeRight
//       // ],
//       controller: controller!,
//       aspectRatio: 9 / 16,
//       builder: (context, player) {
//         return SafeArea(
//           child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             backgroundColor: Colors.black,
//             body: Stack(
//               children: [
//                 player,
//                 Positioned(
//                   left: 10.0,
//                   bottom: 190.0,
//                   child: textTile(
//                     context: context,
//                     data: widget.videoDetail!.content!.creator!,
//                   ),
//                 ),
//                 Positioned(
//                   left: 10.0,
//                   bottom: 155.0,
//                   child: textTile(
//                     context: context,
//                     data: timeAgo(widget.videoDetail!.timeStamp!),
//                   ),
//                 ),
//                 Positioned(
//                   left: 10.0,
//                   bottom: 120.0,
//                   child: textTile(
//                     context: context,
//                     data: widget.videoDetail!.newsType,
//                   ),
//                 ),
//                 // Container(
//                 //   height: double.infinity,
//                 //   width: double.infinity,
//                 //   color: Colors.transparent,
//                 // ),
//                 Positioned(
//                   right: 20.0,
//                   bottom: 210,
//                   child: Obx(
//                     () => InkWell(
//                       onTap: () {
//                         newsController.likeAndUnlikeNews(
//                           data: widget.videoDetail,
//                           isLiked: newsController.allFavouriteNewsItem.any(
//                                   (element) =>
//                                       element.newsId ==
//                                       widget.videoDetail!.newsId)
//                               ? false
//                               : true,
//                         );
//                       },
//                       child: FaIcon(
//                         newsController.allFavouriteNewsItem.any((element) =>
//                                 element.newsId == widget.videoDetail!.newsId)
//                             ? FontAwesomeIcons.solidHeart
//                             : FontAwesomeIcons.heart,
//                         color: newsController.allFavouriteNewsItem.any(
//                                 (element) =>
//                                     element.newsId ==
//                                     widget.videoDetail!.newsId)
//                             ? redOpacityColor
//                             : Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 10.0,
//                   bottom: 150,
//                   child: IconButton(
//                     onPressed: () {
//                       controller!.enterFullScreen();
//                     },
//                     icon: const FaIcon(
//                       FontAwesomeIcons.expand,
//                       color: deepOrangeColor,
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Obx(
//                     () => IconButton(
//                       onPressed: () {
//                         if (vrController.isVideoPlaying.value == true) {
//                           controller!.pauseVideo();
//                         } else {
//                           controller!.playVideo();
//                         }
//                       },
//                       icon: FaIcon(
//                         vrController.isVideoPlaying.value
//                             ? FontAwesomeIcons.pause
//                             : FontAwesomeIcons.play,
//                         color: deepOrangeColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Text textTile({BuildContext? context, String? data}) {
//     return Text(
//       data!,
//       style: themeTextStyle(
//         context: context,
//         fweight: FontWeight.w500,
//         tColor: whiteColor,
//       ),
//     );
//   }
// }