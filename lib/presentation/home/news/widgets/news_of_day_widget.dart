import 'package:datacoup/export.dart';

class NewsOfTheDayWidget extends StatefulWidget {
  const NewsOfTheDayWidget({super.key});

  @override
  State<NewsOfTheDayWidget> createState() => _NewsOfTheDayWidgetState();
}

class _NewsOfTheDayWidgetState extends State<NewsOfTheDayWidget> {
  final newsController = Get.find<NewsController>();

  NewsModel? newsModel;

  @override
  void initState() {
    loadNewofDay();
    super.initState();
  }

  loadNewofDay() async {
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
          : PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsModel!.items!.length,
              itemBuilder: (context, index) {
                final data = newsModel!.items![index];
                return Stack(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius + 5),
                              ),
                              child: Text(
                                "News of the day",
                                style: themeTextStyle(
                                  context: context,
                                  tColor: whiteColor,
                                  fsize: kminiFont(context),
                                  fweight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: height(context)! * 0.01),
                            Text(
                              data.title!,
                              style: themeTextStyle(
                                context: context,
                                tColor: whiteColor,
                                fweight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height(context)! * 0.05),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => WebViewWidget(
                                          data: data,
                                          url: data.content!.link,
                                          showAppbar: true,
                                        ));
                                  },
                                  child: Text(
                                    "Learn more",
                                    style: themeTextStyle(
                                      context: context,
                                      tColor: whiteColor,
                                      fsize: ksmallFont(context),
                                      fweight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FaIcon(
                                  FontAwesomeIcons.arrowRight,
                                  color: whiteColor,
                                  size: kmediumFont(context),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
