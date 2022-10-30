import 'package:datacoup/export.dart';

class ProductCart {
  final Product? product;
   int quantity;
  ProductCart({
    this.product,
    this.quantity = 1,
  });
}
