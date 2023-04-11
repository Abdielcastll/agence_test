import 'package:test_app/app/data/data_source/local/data_fake.dart';
import 'package:test_app/app/domain/model/products.dart';
import 'package:test_app/app/domain/repository/products_repositoyr.dart';

class ProductsRepositoryImplement extends ProductsRepository {
  @override
  Future<List<Products>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    return DataFake.products;
  }
}
