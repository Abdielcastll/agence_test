import 'package:test_app/app/domain/model/products.dart';

abstract class ProductsRepository {
  Future<List<Products>> getProducts();
}
