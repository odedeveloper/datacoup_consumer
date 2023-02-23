import 'package:datacoup/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialMediaFeedWidget extends StatefulWidget {
  const SocialMediaFeedWidget({super.key});

  @override
  State<SocialMediaFeedWidget> createState() => SocialMediaFeedWidgetState();
}

class SocialMediaFeedWidgetState extends State<SocialMediaFeedWidget> {
  final newsController = Get.find<NewsController>();
  NewsModel? newsModel;
  final pageController = PageController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    newsController.socialMediaLoader(true);
    newsModel = await newsController.getAllNews(
      type: StringConst.socialFeedtype,
      count: newsController.newsOfDayCount.value,
    );
    newsController.socialMediaLoader(false);
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

  getSocialMediaIcon(String creator) {
    switch (creator) {
      case "Twitter":
        return FontAwesomeIcons.twitter;
      case "Facebook":
        return FontAwesomeIcons.facebook;
      case "LinkedIn":
        return FontAwesomeIcons.linkedin;
      default:
        return FontAwesomeIcons.thumbsUp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: NewsScreenAppBar(
            image: AssetConst.FEED_LOGO,
            title: "Feeds",
            subTitle: "From all across social media !",
          ),
        ),
        body: Obx(
          () => newsController.socialMediaLoader.value
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ShimmerBox(
                      height: double.infinity, width: double.infinity),
                )
              : newsModel == null
                  ? Center(
                      child: Text(
                        "No data found!",
                        style: themeTextStyle(context: context),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  // controller: pageController,
                                  itemCount: newsModel!.items!.length,
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => WebViewWidget(
                                              showAppbar: true,
                                              title:
                                                  "${newsModel!.items![index].content!.creator!} feed",
                                              data: newsModel!.items![index],
                                              url: newsModel!.items![index]
                                                          .content!.creator ==
                                                      "Twitter"
                                                  ? 'https://twitter.com/${newsModel!.items![index].content!.link}'
                                                  : newsModel!.items![index]
                                                      .content!.link,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 100,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 10),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Theme.of(context).cardColor,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 85.w,
                                                height: 80.h,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kBorderRadius),
                                                  child: Icon(
                                                      getSocialMediaIcon(
                                                          newsModel!
                                                              .items![index]
                                                              .content!
                                                              .creator!)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290.w,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8.0.h,
                                                      horizontal: 8.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        newsModel!.items![index]
                                                            .description!,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: themeTextStyle(
                                                          context: context,
                                                          tColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontFamily: AssetConst
                                                              .QUICKSAND_FONT,
                                                          fsize: ksmallFont(
                                                              context),
                                                          fweight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        timeAgo(newsModel!
                                                            .items![index]
                                                            .timeStamp!),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: themeTextStyle(
                                                          context: context,
                                                          fweight:
                                                              FontWeight.w600,
                                                          fsize: kminiFont(
                                                              context),
                                                          tColor: Theme.of(
                                                                  context)
                                                              .primaryColor
                                                              .withOpacity(0.6),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      const SizedBox(height: 2),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Stack(
                                        //   children: [
                                        //     WebViewWidget(
                                        //       showAppbar: false,
                                        //       showFav: false,
                                        //       data: newsModel!.items![index],
                                        //       url: newsModel!.items![index]
                                        //                   .content!.creator ==
                                        //               "Twitter"
                                        //           ? 'https://twitter.com/${newsModel!.items![index].content!.link}'
                                        //           : newsModel!.items![index]
                                        //               .content!.link,
                                        //     ),
                                        //     Container(
                                        //         color: Colors.transparent)
                                        //   ],
                                        // ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Positioned(
                              //   left: 0.0,
                              //   bottom: height(context)! * 0.4,
                              //   child: IconButton(
                              //     onPressed: () {
                              //       pageController.previousPage(
                              //         duration: const Duration(seconds: 1),
                              //         curve: Curves.linear,
                              //       );
                              //     },
                              //     icon: const FaIcon(
                              //       FontAwesomeIcons.circleArrowLeft,
                              //       size: 22,
                              //     ),
                              //   ),
                              // ),
                              // Positioned(
                              //   right: 0.0,
                              //   bottom: height(context)! * 0.4,
                              //   child: IconButton(
                              //     onPressed: () {
                              //       pageController.nextPage(
                              //         duration: const Duration(seconds: 1),
                              //         curve: Curves.linear,
                              //       );
                              //     },
                              //     icon: const FaIcon(
                              //       FontAwesomeIcons.circleArrowRight,
                              //       size: 22,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
