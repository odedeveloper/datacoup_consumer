import 'package:datacoup/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final newsController = Get.find<NewsController>();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData({int? token}) async {
    await newsController.getAllFavouriteNews(
      type: true,
      count: token ?? newsController.newsOfDayCount.value,
    );
    newsController.favouriteLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => newsController.allFavouriteNewsItem.isEmpty
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 100.h),
                  child: Text(
                    "Haven't liked anything yet!",
                    style: themeTextStyle(context: context),
                  ),
                ),
              )
            : Column(
                children: [
                  // Container(
                  //   margin: EdgeInsets.only(left: 20, right: 20),
                  //   alignment: Alignment.centerLeft,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       border: Border.all(width: 2, color: greyColor)),
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Icon(Icons.search),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text(" Search your favourite items !",
                  //           style: TextStyle(
                  //               fontSize: 15,
                  //               color: darkBlueGreyColor,
                  //               fontFamily: AssetConst.QUICKSAND_FONT,
                  //               fontWeight: FontWeight.w800)),
                  //     ],
                  //   ),
                  // ),
                  // Expanded(
                  // flex: 1,
                  // child: Container(
                  //   margin: EdgeInsets.only(left: 20, right: 20),
                  //   height: 40,
                  //  child: Icon(Icons.),
                  // ))

                  // Expanded(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       ActionChip(
                  //         padding: const EdgeInsets.symmetric(horizontal: 24),
                  //         label: const Text("Articles"),
                  //         onPressed: () {},
                  //       ),
                  //       // ActionChip(
                  //       //   padding: const EdgeInsets.symmetric(horizontal: 24),
                  //       //   label: const Text("Photos"),
                  //       //   onPressed: () {},
                  //       // ),
                  //       ActionChip(
                  //         padding: const EdgeInsets.symmetric(horizontal: 24),
                  //         label: const Text("Videos"),
                  //         onPressed: () {},
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    flex: 10,
                    child: newsController.favouriteLoader.value
                        ? ListView.separated(
                            physics: const ClampingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 30),
                            padding: const EdgeInsets.all(12),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: height(context)! * 0.3,
                                width: width(context)! * 0.5,
                                child: const ShimmerBox(
                                    height: double.infinity,
                                    width: double.infinity,
                                    radius: 12),
                              );
                            },
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount:
                                newsController.allFavouriteNewsItem.length,
                            padding: const EdgeInsets.all(12),
                            itemBuilder: (context, index) {
                              // if (index ==
                              //     newsController.allFavouriteNewsItem.length - 2) {
                              //   loadData(
                              //       token: newsController.newsOfDayCount.value + 5);
                              // }
                              return Padding(
                                padding: (newsController
                                            .allFavouriteNewsItem.length ==
                                        index + 1)
                                    ? EdgeInsets.only(bottom: 70)
                                    : EdgeInsets.zero,
                                child: NewsCardWidget(
                                  data: newsController
                                      .allFavouriteNewsItem[index],
                                  imageHeight: 210,
                                  showFavButton: true,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
