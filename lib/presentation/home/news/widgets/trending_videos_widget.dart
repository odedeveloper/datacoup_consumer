import 'package:datacoup/export.dart';
import 'dart:math';

class TrendingVideosWidget extends StatefulWidget {
  const TrendingVideosWidget({super.key});

  @override
  State<TrendingVideosWidget> createState() => TrendingVideosWidgetState();
}

class TrendingVideosWidgetState extends State<TrendingVideosWidget> {
  final newsController = Get.find<NewsController>();
  final ScrollController _horizontal = ScrollController();
  NewsModel? newsModel;

  @override
  void initState() {
    laodData();
    super.initState();
  }

  laodData() async {
    newsController.trendingVideoLoader(true);
    String getRandomCategory() {
      Random random = Random();
      int limit = newsController.keyInterestAreas.length;
      int randomNumber = random.nextInt(limit);
      return newsController.keyInterestAreas[randomNumber]
          .replaceAll("_Article", "_Video");
    }

    Future.delayed(const Duration(seconds: 1), () async {
      newsModel = await newsController.getAllNews(
        type: getRandomCategory(),
        count: newsController.newsOfDayCount.value,
      );
      newsController.trendingVideoLoader(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringConst.trendingVideosTitle,
                style: themeTextStyle(
                  context: context,
                  fsize: ksmallFont(context),
                  fweight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  laodData();
                },
                icon: const FaIcon(
                  FontAwesomeIcons.arrowRotateLeft,
                  size: 16,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Obx(
            () => newsController.trendingVideoLoader.value
                ? ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 27),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) => Container(
                      width: width(context)! * 0.5,
                      padding: const EdgeInsets.all(8.0),
                      child: const ShimmerBox(
                          height: double.infinity,
                          width: double.infinity,
                          radius: 12),
                    ),
                  )
                : newsModel == null
                    ? Center(
                        child: Text(
                          "No data found!",
                          style: themeTextStyle(context: context),
                        ),
                      )
                    : ListView.separated(
                        controller: _horizontal,
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 25),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemCount: newsModel!.items!.length,
                        itemBuilder: (context, index) {
                          return NewsCardWidget(
                            data: newsModel!.items![index],
                          );
                        },
                      ),
          ),
        ),
      ],
    );
  }
}
