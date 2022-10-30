import 'package:datacoup/export.dart';

class ProductController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  ProductController({
    required this.apiRepositoryInterface,
  });

  RxList<Product> productList = <Product>[].obs;

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }

  void loadProducts() async {
    final result = await apiRepositoryInterface.getProduct();
    productList.value = result!;
  }
}
