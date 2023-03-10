import 'package:datacoup/export.dart';

class NewsCard extends StatelessWidget {
  NewsCard({
    super.key,
    required this.data,
    this.imageHeight,
  });
  final double? imageHeight;
  final Item? data;

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
    return "Just now";
  }

  final newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return !(data != null && data!.headerMultimedia != null)
        ? const SizedBox.shrink()
        : InkWell(
            onTap: () {
              Get.to(() => WebViewWidget(
                    url: data!.content!.link,
                    data: data,
                    title: "Article",
                    showAppbar: true,
                  ));
            },
            child: Container(
              height: 120.h,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 85.w,
                    height: 88.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                      child: CacheImageWidget(
                        imageUrl: data!.headerMultimedia,
                        imgheight: 20.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 290.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0.h, horizontal: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data!.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: themeTextStyle(
                              context: context,
                              tColor: Theme.of(context).primaryColor,
                              fontFamily: AssetConst.QUICKSAND_FONT,
                              fsize: ksmallFont(context)!.h,
                              fweight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            timeAgo(data!.timeStamp!),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: themeTextStyle(
                              context: context,
                              fweight: FontWeight.w600,
                              fsize: kminiFont(context),
                              tColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            "by ${data!.content!.creator}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: themeTextStyle(
                              context: context,
                              fweight: FontWeight.w500,
                              fsize: kminiFont(context),
                              tColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
