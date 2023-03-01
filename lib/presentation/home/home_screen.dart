import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/news/widgets/appbar_home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends GetWidget<HomeController> {
  HomeScreen({super.key});

  final newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity,
                controller.onIndexSelected.value == 4 ? 0 : 80.h),
            child: controller.onIndexSelected.value == 1
                ? NewsScreenAppBar(
                    image: AssetConst.FEED_LOGO,
                    title: "Favorites ",
                    subTitle: "Find your liked items here !",
                  )
                : controller.onIndexSelected.value == 2
                    ? NewsScreenAppBar(
                        image: AssetConst.QUIZ_LOGO,
                        title: "Quizzes",
                        subTitle: "Test your knowledge !",
                      )
                    : controller.onIndexSelected.value == 3
                        ? NewsScreenAppBar(
                            image: AssetConst.VIDEO_LOGO,
                            title: "Videos",
                            subTitle: "Watch and take action !",
                          )
                        : controller.onIndexSelected.value == 4
                            ? Container()
                            // ? NewsScreenAppBar(
                            //     image: AssetConst.LOGO,
                            //     title: "Profile",
                            //     subTitle: "",
                            //   )
                            : HomeAppBar()
            // HomeAppBar(),

            // NewsScreenAppBar(
            //   title: controller.onIndexSelected.value == 1
            //       ? "favourite".tr
            //       : controller.onIndexSelected.value == 2
            //           ? "quizzes".tr
            //           : controller.onIndexSelected.value == 3
            //               ? "videos".tr
            //               : controller.onIndexSelected.value == 4
            //                   ? 'profile'.tr
            //                   : null,
            // ),
            ),
        body: RefreshIndicator(
          onRefresh: newsController.refreshAll,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              IndexedStack(
                index: controller.onIndexSelected.value,
                children: const [
                  NewsScreen(),
                  FavouriteScreen(),
                  // Container(),
                  QnaProfile(),
                  VideoScreen(),
                  ProfileScreen(),
                ],
              ),
              Obx(
                () => SafeArea(
                  child: AppBottomNavgationBar(
                    index: controller.onIndexSelected.value,
                    onIndexSelected: (value) {
                      controller.updateIndexSelected(value);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppBottomNavgationBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;
  final controller = Get.find<HomeController>();
  AppBottomNavgationBar({
    Key? key,
    required this.index,
    required this.onIndexSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 25, right: 25),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(115, 143, 142, 142),
              blurRadius: 15,
              spreadRadius: 15,
              offset: Offset(0.0, 0.01),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          bottomNavButtons(
            onClicked: () => onIndexSelected(0),
            iconData: FontAwesomeIcons.house,
            isSelected: controller.onIndexSelected.value == 0,
            color: controller.onIndexSelected.value == 0
                ? deepOrangeColor
                : Theme.of(context).primaryColor,
          ),
          bottomNavButtons(
            onClicked: () => onIndexSelected(1),
            iconData: FontAwesomeIcons.solidHeart,
            isSelected: controller.onIndexSelected.value == 1,
            color: controller.onIndexSelected.value == 1
                ? deepOrangeColor
                : Theme.of(context).primaryColor,
          ),
          bottomNavButtons(
            onClicked: () => onIndexSelected(2),
            iconData: FontAwesomeIcons.solidLightbulb,
            isSelected: controller.onIndexSelected.value == 2,
            color: controller.onIndexSelected.value == 2
                ? deepOrangeColor
                : Theme.of(context).primaryColor,
          ),
          bottomNavButtons(
            onClicked: () => onIndexSelected(3),
            iconData: FontAwesomeIcons.play,
            isSelected: controller.onIndexSelected.value == 3,
            color: controller.onIndexSelected.value == 3
                ? deepOrangeColor
                : Theme.of(context).primaryColor,
          ),
          bottomNavButtons(
            onClicked: () => onIndexSelected(4),
            iconData: FontAwesomeIcons.solidUser,
            isSelected: controller.onIndexSelected.value == 4,
            color: controller.onIndexSelected.value == 4
                ? deepOrangeColor
                : Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  bottomNavButtons({
    required VoidCallback onClicked,
    required IconData iconData,
    required Color color,
    required bool isSelected,
  }) =>
      // Container(
      //   padding:
      //       EdgeInsets.symmetric(horizontal: isSelected ? 5 : 0, vertical: 0),
      //   decoration: isSelected
      //       ? BoxDecoration(
      //           border: Border.all(width: 2, color: greyColor),
      //           borderRadius: BorderRadius.circular(25))
      //       : null,
      //   child:

      IconButton(
        onPressed: onClicked,
        icon: FaIcon(
          iconData,
          color: color,
          size: 22,
        ),
        // ),
      );
}
