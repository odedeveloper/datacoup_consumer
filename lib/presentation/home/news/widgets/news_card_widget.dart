import 'package:datacoup/export.dart';

class NewsCardWidget extends StatelessWidget {
  NewsCardWidget(
      {super.key,
      required this.data,
      this.imageHeight,
      this.showFavButton = false});
  final double? imageHeight;
  final Item? data;
  final bool? showFavButton;

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

  final newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    print('----____----');
    print(data!.headerMultimedia);
    return !(data != null && data!.headerMultimedia != null)
        ? Container()
        : data!.newsType == "Feed"
            ? Container(
                width: width(context)! * 0.45,
                height: height(context)! * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  color: Colors.grey,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      spreadRadius: 0.2,
                      blurRadius: 0.2,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        () => WebViewWidget(
                          showAppbar: true,
                          data: data,
                          url: data!.content!.creator == "Twitter"
                              ? 'https://twitter.com/${data!.content!.link}'
                              : data!.content!.link,
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        WebViewWidget(
                          data: data!,
                          showAppbar: false,
                          showFav: false,
                          url: data!.content!.creator == "Twitter"
                              ? 'https://twitter.com/${data!.content!.link}'
                              : data!.content!.link,
                        ),
                        Container(color: Colors.transparent),
                        Positioned(
                          right: 0.0,
                          bottom: 0.0,
                          child: showFavButton!
                              ? IconButton(
                                  onPressed: () {
                                    newsController.likeAndUnlikeNews(
                                      data: data,
                                      isLiked: newsController
                                              .allFavouriteNewsItem
                                              .any((element) =>
                                                  element.newsId ==
                                                  data!.newsId)
                                          ? false
                                          : true,
                                    );
                                  },
                                  icon: FaIcon(
                                    data!.isFavourite!
                                        ? FontAwesomeIcons.solidHeart
                                        : FontAwesomeIcons.heart,
                                    color: data!.isFavourite!
                                        ? redOpacityColor
                                        : Theme.of(context).primaryColor,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  Get.to(() => WebViewWidget(
                        url: data!.content!.link,
                        data: data,
                        showAppbar: true,
                      ));
                },
                child: Container(
                  width: width(context)! * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          spreadRadius: 0.2,
                          blurRadius: 0.2,
                        )
                      ]),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(kBorderRadius),
                            child: CacheImageWidget(
                              imageUrl: data!.headerMultimedia,
                              imgheight: imageHeight ?? height(context)! * 0.11,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data!.title!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: themeTextStyle(
                                    context: context,
                                    fsize: kminiFont(context),
                                    fweight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  timeAgo(data!.timeStamp!),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: themeTextStyle(
                                    context: context,
                                    fweight: FontWeight.w600,
                                    fsize: kminiFont(context),
                                    tColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "by ${data!.content!.creator}",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: themeTextStyle(
                                    context: context,
                                    fweight: FontWeight.w500,
                                    fsize: kminiFont(context),
                                    tColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: showFavButton!
                            ? IconButton(
                                onPressed: () {
                                  newsController.likeAndUnlikeNews(
                                    data: data,
                                    isLiked: newsController.allFavouriteNewsItem
                                            .any((element) =>
                                                element.newsId == data!.newsId)
                                        ? false
                                        : true,
                                  );
                                },
                                icon: FaIcon(
                                  data!.isFavourite!
                                      ? FontAwesomeIcons.solidHeart
                                      : FontAwesomeIcons.heart,
                                  color: data!.isFavourite!
                                      ? redOpacityColor
                                      : Theme.of(context).primaryColor,
                                ),
                              )
                            : const SizedBox.shrink(),
                      )
                    ],
                  ),
                ),
              );
  }
}
