import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/video_reels/widgets/youtube_player_widget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.items,
    this.startIndex,
  }) : super(key: key);

  final int? startIndex;
  final List<Item>? items;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late PageController _pageController;
  final newsController = Get.find<NewsController>();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
    _pageController = PageController(initialPage: widget.startIndex!);
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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.black,
      //   iconTheme: const IconThemeData(color: deepOrangeColor),
      // ),
      body: PageView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        controller: _pageController,
        itemCount: widget.items!.length,
        itemBuilder: (context, index) => Stack(children: [
          YoutuberPlayerWidget(
            playFull: true,
            videoDetail: widget.items![index],
          ),
          Positioned(
              left: 0,
              top: 0,
              child: Container(
                color: Colors.transparent,
                height: height(context)! * 0.6,
                width: width(context),
              )),
          Positioned(
              left: 0,
              top: 10.0,
              child: BackButton(
                color: deepOrangeColor,
              )),

          OrientationBuilder(builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        textTile(
                          context: context,
                          data: widget.items![index].content!.creator!,
                        ),
                        textTile(
                          context: context,
                          data: timeAgo(widget.items![index].timeStamp!),
                        ),
                        textTile(
                          context: context,
                          data: widget.items![index].newsType!
                              .split("_")
                              .join(" "),
                        ),
                      ],
                    ),
                  )
                : Container();
          }),
          // Positioned(
          //   left: 10.0,
          //   bottom: 190.0,
          //   child: textTile(
          //     context: context,
          //     data: widget.items![index].content!.creator!,
          //   ),
          // ),
          // Positioned(
          //   left: 10.0,
          //   bottom: 155.0,
          //   child: textTile(
          //     context: context,
          //     data: timeAgo(widget.items![index].timeStamp!),
          //   ),
          // ),
          // Positioned(
          //   left: 10.0,
          //   bottom: 120.0,
          //   child: textTile(
          //     context: context,
          //     data: widget.items![index].newsType!.split("_").join(" "),
          //   ),
          // ),
          // Container(
          //   height: double.infinity,
          //   width: double.infinity,
          //   color: Colors.transparent,
          // ),
          Positioned(
            right: 20.0,
            bottom: 180,
            child: Obx(
              () => InkWell(
                onTap: () {
                  newsController.likeAndUnlikeNews(
                    data: widget.items![index],
                    isLiked: newsController.allFavouriteNewsItem.any(
                            (element) =>
                                element.newsId == widget.items![index].newsId)
                        ? false
                        : true,
                  );
                },
                child: FaIcon(
                  newsController.allFavouriteNewsItem.any((element) =>
                          element.newsId == widget.items![index].newsId)
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  color: newsController.allFavouriteNewsItem.any((element) =>
                          element.newsId == widget.items![index].newsId)
                      ? deepOrangeColor
                      : Colors.white,
                ),
              ),
            ),
          ),
        ]),
        scrollDirection: Axis.vertical,
        onPageChanged: (i) {},
      ),
    );
  }
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
