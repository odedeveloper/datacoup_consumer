import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/news/widgets/news_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsByInterest extends StatefulWidget {
  const NewsByInterest({Key? key}) : super(key: key);

  @override
  State<NewsByInterest> createState() => NewsByInterestState();
}

class NewsByInterestState extends State<NewsByInterest> {
  final newsController = Get.find<NewsController>();

  NewsModel? newsModel;
  final ScrollController _horizontal = ScrollController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    newsController.interestNewsLoader(true);
    newsModel = await newsController.getAllNews(
      type: newsController.selectedkeyInterest.value,
      count: newsController.newsOfDayCount.value,
    );
    newsController.interestNewsLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(children: [
        SizedBox(
          height: 60.h,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10.h),
            scrollDirection: Axis.horizontal,
            itemCount: newsController.keyInterestAreas.length,
            itemBuilder: (context, index) => InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                newsController.selectedkeyInterest.value =
                    newsController.keyInterestAreas[index];
                await loadData();
              },
              child: Container(
                width: 130.w,
                decoration: BoxDecoration(
                  color: newsController.selectedkeyInterest.value ==
                          newsController.keyInterestAreas[index]
                      ? deepOrangeColor
                      : greyColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(newsController.keyInterestAreas[index] == "Protect yourself_Article" ? "Protect Yourself":
                    newsController.keyInterestAreas[index]
                        .replaceAll("_Article", ""),
                    style: themeTextStyle(
                      context: context,
                      fsize: 14.w,
                      fweight: FontWeight.w800,
                      fontFamily: AssetConst.QUICKSAND_FONT,
                      tColor: newsController.selectedkeyInterest.value ==
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
        SizedBox(
          height: 415.h,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            controller: _horizontal,
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 27.h),
            scrollDirection: Axis.vertical,
            itemCount: newsController.interestNewsLoader.value
                ? 3
                : newsModel!.items!.length,
            itemBuilder: (context, index) {
              return newsController.interestNewsLoader.value
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 5),
                      width: width(context)! * 0.8,
                      child: ShimmerBox(
                          height: 100.h, width: double.infinity, radius: 12),
                    )
                  : newsModel != null &&
                          newsModel!.items != null &&
                          newsModel!.items![index] != null
                      ? NewsCard(data: newsModel!.items![index])
                      : Container();
            },
          ),
        ),
      ]),
      // Expanded(
      //   flex: 9,
      //   child: newsController.interestNewsLoader.value
      //       ? ListView.separated(
      //           separatorBuilder: (context, index) =>
      //               const SizedBox(width: 10),
      //           padding:
      //               const EdgeInsets.only(left: 12, right: 12, bottom: 27),
      //           scrollDirection: Axis.vertical,
      //           itemCount: 3,
      //           itemBuilder: (context, index) => SizedBox(
      //             width: width(context)! * 0.5,
      //             child: const ShimmerBox(
      //                 height: double.infinity,
      //                 width: double.infinity,
      //                 radius: 12),
      //           ),
      //         )
      //       : newsModel == null
      //           ? Center(
      //               child: Text(
      //                 "No data found!",
      //                 style: themeTextStyle(context: context),
      //               ),
      //             )
      //           : ListView.separated(
      //               physics: const ClampingScrollPhysics(),
      //               controller: _horizontal,
      //               padding: const EdgeInsets.only(
      //                   left: 12, right: 12, bottom: 27),
      //               scrollDirection: Axis.horizontal,
      //               separatorBuilder: (context, index) =>
      //                   const SizedBox(width: 10),
      //               itemCount: newsModel!.items!.length,
      //               itemBuilder: (context, index) {
      //                 return newsModel != null &&
      //                         newsModel!.items != null &&
      //                         newsModel!.items![index] != null
      //                     ? NewsCardWidget(data: newsModel!.items![index])
      //                     : Container();
      //               },
      //             ),
      // ),
    );
  }
}
