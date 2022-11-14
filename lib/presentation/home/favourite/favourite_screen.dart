import 'package:datacoup/export.dart';

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
    await newsController.getAllFavouriteNes(
      type: true,
      count: token ?? newsController.newsOfDayCount.value,
    );
    newsController.favouriteLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Favourites",
          style: themeTextStyle(
            context: context,
            fsize: klargeFont(context),
            fweight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionChip(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    label: const Text("Articles"),
                    onPressed: () {},
                  ),
                  // ActionChip(
                  //   padding: const EdgeInsets.symmetric(horizontal: 24),
                  //   label: const Text("Photos"),
                  //   onPressed: () {},
                  // ),
                  ActionChip(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    label: const Text("Videos"),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: newsController.favouriteLoader.value
                  ? ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
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
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: newsController.allFavouriteNewsItem.length,
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        // if (index ==
                        //     newsController.allFavouriteNewsItem.length - 2) {
                        //   loadData(
                        //       token: newsController.newsOfDayCount.value + 5);
                        // }
                        return NewsCardWidget(
                          data: newsController.allFavouriteNewsItem[index],
                          imageHeight: height(context)! * 0.2,
                          showFavButton: true,
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
