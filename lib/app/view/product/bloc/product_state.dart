import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_app/app/domain/model/products.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(false) bool loading,
    Products? product,
    LatLng? location,
  }) = _ProductState;

  const ProductState._();
}
