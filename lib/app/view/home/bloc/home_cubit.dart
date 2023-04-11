import 'package:bloc/bloc.dart';
import 'package:test_app/app/domain/repository/products_repositoyr.dart';
import 'package:test_app/app/view/home/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._productsRepository) : super(const HomeState()) {
    getProducts();
  }

  final ProductsRepository _productsRepository;

  Future<void> getProducts() async {
    emit(state.copyWith(loading: true));
    var products = await _productsRepository.getProducts();
    emit(state.copyWith(loading: false, products: products));
  }
}
