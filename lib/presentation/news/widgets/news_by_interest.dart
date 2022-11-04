import 'package:datacoup/export.dart';

class NewsByInterest extends StatefulWidget {
  const NewsByInterest({Key? key}) : super(key: key);

  @override
  State<NewsByInterest> createState() => _NewsByInterestState();
}

class _NewsByInterestState extends State<NewsByInterest> {
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
      () => Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              scrollDirection: Axis.horizontal,
              itemCount: newsController.keyInterestAreas.length,
              itemBuilder: (context, index) => InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  newsController.selectedkeyInterest.value =
                      newsController.keyInterestAreas[index];
                  await loadData();
                },
                child: Container(
                  width: width(context)! * 0.35,
                  decoration: BoxDecoration(
                      color: newsController.selectedkeyInterest.value ==
                              newsController.keyInterestAreas[index]
                          ? darkSkyBlueColor
                          : whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          spreadRadius: 0.4,
                          blurRadius: 0.4,
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      newsController.keyInterestAreas[index]
                          .replaceAll("_Article", ""),
                      style: themeTextStyle(
                        context: context,
                        fsize: kminiFont(context)! + 1,
                        fweight: FontWeight.bold,
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
          Expanded(
            flex: 9,
            child: newsController.interestNewsLoader.value
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ShimmerBox(
                        height: double.infinity,
                        width: double.infinity,
                        radius: 0),
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
                        controller: _horizontal,
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 27),
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
        ],
      ),
    );
  }
}
