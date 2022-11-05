import 'package:datacoup/export.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget(
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => WebViewWidget(
              url: data!.content!.link,
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
                          tColor:
                              Theme.of(context).primaryColor.withOpacity(0.4),
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
                          tColor:
                              Theme.of(context).primaryColor.withOpacity(0.4),
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
                      onPressed: () {},
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
