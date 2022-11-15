import 'package:datacoup/export.dart';

class NewsOfTheDayWidget extends StatefulWidget {
  const NewsOfTheDayWidget({super.key});

  @override
  State<NewsOfTheDayWidget> createState() => NewsOfTheDayWidgetState();
}

class NewsOfTheDayWidgetState extends State<NewsOfTheDayWidget> {
  final newsController = Get.find<NewsController>();

  NewsModel? newsModel;

  @override
  void initState() {
    loadNewofDay();
    super.initState();
  }

  loadNewofDay() async {
     newsController.newsOfDayLoader(true);
    newsModel = await newsController.getAllNews(
      type: StringConst.newsOfTheDay,
      count: newsController.newsOfDayCount.value,
    );
    newsController.newsOfDayLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => newsController.newsOfDayLoader.value
          ? const ShimmerBox(height: double.infinity, width: double.infinity)
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          StringConst.newsOftheDayTitle,
                          style: themeTextStyle(
                            context: context,
                            fsize: ksmallFont(context),
                            fweight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: newsModel!.items!.length,
                    itemBuilder: (context, index) {
                      final data = newsModel!.items![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          child: Stack(
                            children: [
                              CacheImageWidget(
                                imageUrl: data.headerMultimedia,
                                color: Colors.black54,
                                colorBlendMode: BlendMode.darken,
                              ),
                              Positioned(
                                top: height(context)! * 0.05,
                                left: width(context)! * 0.05,
                                child: SizedBox(
                                  width: width(context)! * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title!,
                                        style: themeTextStyle(
                                          context: context,
                                          tColor: whiteColor,
                                          fweight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: height(context)! * 0.02),
                                      Text(
                                        data.description!,
                                        style: themeTextStyle(
                                          context: context,
                                          tColor: whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10.0,
                                bottom: 10.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => WebViewWidget(
                                          data: data,
                                          url: data.content!.link,
                                          showAppbar: true,
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: Colors.transparent,
                                    shape: const StadiumBorder(
                                        side: BorderSide(color: Colors.grey)),
                                  ),
                                  child: const Text(
                                    "Learn more",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
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
