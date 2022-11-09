import 'package:datacoup/export.dart';
import 'dart:io';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.onIndexSelected.value,
                children: const [
                  NewsScreen(),
                  FavouriteScreen(),
                  QuizScreen(),
                  VideoReelsScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
          ),
          Obx(
            () => AppBottomNavgationBar(
              index: controller.onIndexSelected.value,
              onIndexSelected: (value) {
                controller.updateIndexSelected(value);
              },
            ),
          )
        ],
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
      decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 0.5,
              spreadRadius: 0.5,
              offset: Offset(0.3, 0.8),
            ),
          ]),
      padding: Platform.isAndroid
          ? const EdgeInsets.only(top: 5, bottom: 2)
          : const EdgeInsets.only(top: 5, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          bottomNavButtons(
            onClicked: () => onIndexSelected(0),
            iconData: FontAwesomeIcons.house,
            color: controller.onIndexSelected.value == 0
                ? deepOrangeColor
                : Colors.grey,
          ),
          bottomNavButtons(
            onClicked: () => onIndexSelected(1),
            iconData: FontAwesomeIcons.solidHeart,
            color: controller.onIndexSelected.value == 1
                ? deepOrangeColor
                : Colors.grey,
          ),
          bottomNavButtons(
            onClicked: () => onIndexSelected(2),
            iconData: FontAwesomeIcons.solidLightbulb,
            color: controller.onIndexSelected.value == 2
                ? deepOrangeColor
                : Colors.grey,
          ),
          bottomNavButtons(
            onClicked: () => onIndexSelected(3),
            iconData: FontAwesomeIcons.play,
            color: controller.onIndexSelected.value == 3
                ? deepOrangeColor
                : Colors.grey,
          ),
          bottomNavButtons(
            onClicked: () => onIndexSelected(4),
            iconData: FontAwesomeIcons.solidUser,
            color: controller.onIndexSelected.value == 4
                ? deepOrangeColor
                : Colors.grey,
          ),
        ],
      ),
    );
  }

  IconButton bottomNavButtons(
          {required VoidCallback onClicked,
          required IconData iconData,
          required Color color}) =>
      IconButton(
        onPressed: onClicked,
        icon: FaIcon(
          iconData,
          color: color,
          size: 22,
        ),
      );
}
