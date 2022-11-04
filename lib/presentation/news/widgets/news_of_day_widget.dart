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
      lastEvaluatedKey: null,
    );
    newsController.newsOfDayLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => newsController.newsOfDayLoader.value
          ? const ShimmerBox(
              height: double.infinity, width: double.infinity, radius: 0)
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
                      top: 30,
                      left: 20,
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
                                fsize: ksmallFont(context),
                                fweight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: height(context)! * 0.04),
                            Row(
                              children: [
                                Text(
                                  "Learn more",
                                  style: themeTextStyle(
                                    context: context,
                                    tColor: whiteColor,
                                    fsize: ksmallFont(context),
                                    fweight: FontWeight.bold,
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
