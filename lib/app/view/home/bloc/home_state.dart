import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/app/domain/model/products.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(<Products>[]) List<Products> products,
    @Default(false) bool loading,
  }) = _HomeState;

  const HomeState._();
}
