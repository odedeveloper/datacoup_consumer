import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/video_reels/video_reels_controller.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutuberPlayerWidget extends StatefulWidget {
  const YoutuberPlayerWidget({super.key, this.videoDetail});
  final Item? videoDetail;

  @override
  State<YoutuberPlayerWidget> createState() => _YoutuberPlayerWidgetState();
}

class _YoutuberPlayerWidgetState extends State<YoutuberPlayerWidget> {
  final vrontroller = Get.put(VideoReelsController());

  final vrController = Get.find<VideoReelsController>();

  final newsController = Get.find<NewsController>();

  YoutubePlayerController? controller;
  YoutubePlayer? ytController;
  var player = const YoutubePlayer();
  @override
  void initState() {
    controller = YoutubePlayerController()
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
    controller!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      backgroundColor: Colors.black,
      controller: controller!,
      aspectRatio: 9 / 16,
      builder: (context, player) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                player,
                Positioned(
                  left: 10.0,
                  bottom: 190.0,
                  child: textTile(
                    context: context,
                    data: widget.videoDetail!.content!.creator!,
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 155.0,
                  child: textTile(
                    context: context,
                    data: timeAgo(widget.videoDetail!.timeStamp!),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 120.0,
                  child: textTile(
                    context: context,
                    data: widget.videoDetail!.newsType,
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.transparent,
                ),
                Positioned(
                  right: 20.0,
                  bottom: 210,
                  child: Obx(
                    () => InkWell(
                      onTap: () {
                        newsController.likeAndUnlikeNews(
                          data: widget.videoDetail,
                          isLiked: newsController.allFavouriteNewsItem.any(
                                  (element) =>
                                      element.newsId ==
                                      widget.videoDetail!.newsId)
                              ? false
                              : true,
                        );
                      },
                      child: FaIcon(
                        newsController.allFavouriteNewsItem.any((element) =>
                                element.newsId == widget.videoDetail!.newsId)
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: newsController.allFavouriteNewsItem.any(
                                (element) =>
                                    element.newsId ==
                                    widget.videoDetail!.newsId)
                            ? redOpacityColor
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10.0,
                  bottom: 150,
                  child: IconButton(
                    onPressed: () {
                      controller!.toggleFullScreen();
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.expand,
                      color: deepOrangeColor,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(
                    () => IconButton(
                      onPressed: () {
                        if (vrController.isVideoPlaying.value == true) {
                          controller!.pauseVideo();
                        } else {
                          controller!.playVideo();
                        }
                      },
                      icon: FaIcon(
                        vrController.isVideoPlaying.value
                            ? FontAwesomeIcons.pause
                            : FontAwesomeIcons.play,
                        color: deepOrangeColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Text textTile({BuildContext? context, String? data}) {
    return Text(
      data!,
      style: themeTextStyle(
        context: context,
        fweight: FontWeight.w500,
        tColor: whiteColor,
      ),
    );
  }
}
