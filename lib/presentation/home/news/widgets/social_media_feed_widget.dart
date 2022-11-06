import 'package:datacoup/export.dart';

class SocialMediaFeedWidget extends StatefulWidget {
  const SocialMediaFeedWidget({super.key});

  @override
  State<SocialMediaFeedWidget> createState() => _SocialMediaFeedWidgetState();
}

class _SocialMediaFeedWidgetState extends State<SocialMediaFeedWidget> {
  final newsController = Get.find<NewsController>();
  NewsModel? newsModel;
  final pageController = PageController();

  @override
  void initState() {
    laodData();
    super.initState();
  }

  laodData() async {
    newsModel = await newsController.getAllNews(
      type: StringConst.socialFeedtype,
      count: newsController.newsOfDayCount.value,
    );
    newsController.socialMediaLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringConst.socialMediaTitle,
                            style: themeTextStyle(
                              context: context,
                              fsize: ksmallFont(context),
                              fweight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: PageView.builder(
                              controller: pageController,
                              itemCount: newsModel!.items!.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => WebViewWidget(
                                          showAppbar: true,
                                          data: newsModel!.items![index],
                                          url: newsModel!.items![index].content!
                                                      .creator ==
                                                  "Twitter"
                                              ? 'https://twitter.com/${newsModel!.items![index].content!.link}'
                                              : newsModel!
                                                  .items![index].content!.link,
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        WebViewWidget(
                                          showAppbar: false,
                                          showFav: false,
                                          data: newsModel!.items![index],
                                          url: newsModel!.items![index].content!
                                                      .creator ==
                                                  "Twitter"
                                              ? 'https://twitter.com/${newsModel!.items![index].content!.link}'
                                              : newsModel!
                                                  .items![index].content!.link,
                                        ),
                                        Container(color: Colors.transparent)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            left: 0.0,
                            bottom: height(context)! * 0.4,
                            child: IconButton(
                              onPressed: () {
                                pageController.previousPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.linear,
                                );
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.circleArrowLeft,
                                size: 22,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0.0,
                            bottom: height(context)! * 0.4,
                            child: IconButton(
                              onPressed: () {
                                pageController.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.linear,
                                );
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.circleArrowRight,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
