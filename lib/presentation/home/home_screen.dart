import 'package:datacoup/export.dart';


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
                children: [
                  ProductScreen(),
                  Center(
                    child: Text("${controller.onIndexSelected.value}"),
                  ),
                  const CartScreen(),
                  Center(
                    child: Text("${controller.onIndexSelected.value}"),
                  ),
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
  final cartController = Get.find<CartController>();
  AppBottomNavgationBar({
    Key? key,
    required this.index,
    required this.onIndexSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          bottomNavButtons(
            onClicked: () => onIndexSelected(0),
            iconData: Icons.home_filled,
            color: controller.onIndexSelected.value == 0
                ? Colors.red
                : Colors.grey,
          ),
          bottomNavButtons(
            onClicked: () => onIndexSelected(1),
            iconData: Icons.shopify_rounded,
            color: controller.onIndexSelected.value == 1
                ? Colors.red
                : Colors.grey,
          ),
          Stack(
            children: [
              bottomNavButtons(
                onClicked: () => onIndexSelected(2),
                iconData: Icons.shopping_basket,
                color: controller.onIndexSelected.value == 2
                    ? Colors.red
                    : Colors.grey,
              ),
              Positioned(
                right: 0,
                child: Obx(() {
                  return cartController.totalItems.value == 0
                      ? const SizedBox.shrink()
                      : CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.pinkAccent,
                          child:
                              Text(cartController.totalItems.value.toString()),
                        );
                }),
              )
            ],
          ),
          bottomNavButtons(
            onClicked: () => onIndexSelected(3),
            iconData: Icons.favorite_border,
            color: controller.onIndexSelected.value == 3
                ? Colors.red
                : Colors.grey,
          ),
          InkWell(
            onTap: () => onIndexSelected(4),
            child: Obx(
              () {
                final user = controller.user?.value;
                return user?.profileImage == null
                    ? const SizedBox.shrink()
                    : CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(user!.profileImage!),
                      );
              },
            ),
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
        icon: Icon(
          iconData,
          color: color,
        ),
      );
}
