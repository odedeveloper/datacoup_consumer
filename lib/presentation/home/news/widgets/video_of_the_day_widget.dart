import 'package:datacoup/export.dart';

class VideoOfTheDayWidget extends StatefulWidget {
  const VideoOfTheDayWidget({super.key});

  @override
  State<VideoOfTheDayWidget> createState() => VideoOfTheDayWidgetState();
}

class VideoOfTheDayWidgetState extends State<VideoOfTheDayWidget> {
  final newsController = Get.find<NewsController>();

  NewsModel? newsModel;

  @override
  void initState() {
    laodData();
    super.initState();
  }

  laodData() async {
    newsController.videoOfDayLoader(true);
    Future.delayed(const Duration(seconds: 1), () async {
      newsModel = await newsController.getAllNews(
        type: StringConst.videoOfTheDay,
        count: newsController.newsOfDayCount.value,
      );
      newsController.videoOfDayLoader(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => newsController.videoOfDayLoader.value
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child:
                  ShimmerBox(height: double.infinity, width: double.infinity),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringConst.videoOftheDayTitle,
                            style: themeTextStyle(
                              context: context,
                              fsize: ksmallFont(context),
                              fweight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed("videoScreen");
                            },
                            child: Text(
                              "View More",
                              style: themeTextStyle(
                                context: context,
                                fsize: ksmallFont(context),
                                tColor: deepOrangeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: newsModel!.items!.length,
                        itemBuilder: (context, index) {
                          final data = newsModel!.items![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius),
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => WebViewWidget(
                                      url: data.content!.link,
                                      data: data,
                                      showAppbar: true,
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    CacheImageWidget(
                                      imageUrl: data.headerMultimedia,
                                      imgheight: double.infinity,
                                      color: Colors.black38,
                                      cFit: BoxFit.cover,
                                      colorBlendMode: BlendMode.darken,
                                    ),
                                    Positioned(
                                      bottom: 10.0,
                                      left: 20,
                                      child: SizedBox(
                                        width: width(context)! * 0.9,
                                        child: Text(
                                          data.title!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: themeTextStyle(
                                            context: context,
                                            tColor: whiteColor,
                                            fsize: ksmallFont(context),
                                            fweight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
