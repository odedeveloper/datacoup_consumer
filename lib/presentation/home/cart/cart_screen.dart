
import 'package:datacoup/export.dart';

class CartScreen extends GetWidget<CartController> {
  final VoidCallback? onShopping;
  const CartScreen({super.key, this.onShopping});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Obx(
        () => controller.totalItems.value == 0
            ? const Center(child: Text("Empty Cart"))
            : const FullCart(),
      ),
    );
  }
}

class FullCart extends GetWidget<CartController> {
  const FullCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 5,
            child: Obx(
              () => ListView.builder(
                itemCount: controller.cartList.length,
                itemBuilder: (context, index) {
                  final productcart = controller.cartList[index];
                  return ShoppingcartProduct(
                    productCart: productcart,
                    onDelete: () {
                      controller.deleteProduct(productcart);
                    },
                    onIncrement: () {
                      controller.increment(productcart);
                    },
                    onDecrement: () {
                      controller.decrement(productcart);
                    },
                  );
                },
              ),
            )),
        Expanded(
            child: Obx(
          () => Container(
            color: Colors.amber.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Total"),
                    Text(controller.totalPrice.toString()),
                  ],
                )
              ],
            ),
          ),
        )),
      ],
    );
  }
}

class ShoppingcartProduct extends StatelessWidget {
  final ProductCart productCart;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  const ShoppingcartProduct(
      {Key? key,
      required this.productCart,
      required this.onDelete,
      required this.onDecrement,
      required this.onIncrement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = productCart.product;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Theme.of(context).canvasColor.withOpacity(0.4),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(product!.image!),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name!),
                      Text(
                        product.description!,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(product.price!.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: onDecrement,
                            child: const Text("-"),
                          ),
                          Text(productCart.quantity.toString()),
                          ElevatedButton(
                            onPressed: onIncrement,
                            child: const Text("+"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -10.0,
            child: ElevatedButton(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.blue, // <-- Button color
                foregroundColor: Colors.red, // <-- Splash color
              ),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
