import 'package:datacoup/export.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  final newsController = Get.find<NewsController>();

  NewsModel? newsModel;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    newsController.interestVideoLoader(true);
    Future.delayed(const Duration(seconds: 1), () async {
      newsModel = await newsController.getAllNews(
        type: newsController.selectedkeyInterestforVideo.value
            .replaceAll("Article", "Video"),
        count: newsController.newsOfDayCount.value,
      );
      newsController.interestVideoLoader(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            Expanded(
              flex: 2,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 10, height: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                scrollDirection: Axis.horizontal,
                itemCount: newsController.keyInterestAreas.length,
                itemBuilder: (context, index) => InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    newsController.selectedkeyInterestforVideo(
                        newsController.keyInterestAreas[index]);
                    await loadData();
                  },
                  child: Container(
                    width: width(context)! * 0.35,
                    decoration: BoxDecoration(
                      color: newsController.selectedkeyInterestforVideo.value ==
                              newsController.keyInterestAreas[index]
                          ? deepOrangeColor
                          : greyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(newsController.keyInterestAreas[index] == "Protect yourself_Article" ? "Protect Yourself" : 
                        newsController.keyInterestAreas[index]
                            .replaceAll("_Article", ""),
                        style: themeTextStyle(
                          context: context,
                          fsize: ksmallFont(context)!,
                          fweight: FontWeight.bold,
                          fontFamily: AssetConst.QUICKSAND_FONT,
                          tColor: newsController
                                      .selectedkeyInterestforVideo.value ==
                                  newsController.keyInterestAreas[index]
                              ? whiteColor
                              : darkGreyColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 25,
              child: newsController.interestVideoLoader.value
                  ? ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          height: height(context)! * 0.3,
                          padding: const EdgeInsets.all(8.0),
                          child: const ShimmerBox(
                            height: double.infinity,
                            width: double.infinity,
                            radius: 12,
                          ),
                        );
                      },
                    )
                  : newsModel == null
                      ? Center(
                          child: Text(
                            "No data found!",
                            style: themeTextStyle(context: context),
                          ),
                        )
                      : ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 27),
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: newsModel!.items!.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: height(context)! * 0.3,
                              child: NewsCardWidget(
                                imageHeight: height(context)! * 0.2,
                                data: newsModel!.items![index],
                              ),
                            );
                          },
                        ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
