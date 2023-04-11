import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'package:test_app/app/domain/model/products.dart';
import 'package:test_app/app/view/product/bloc/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(Products? product) : super(ProductState(product: product));

  final _kInitialLocation = LatLng(40.416775, -3.703790);

  Future<void> requestPermission() async {
    if (state.location != null) return;
    emit(state.copyWith(loading: true));
    final locationPlugin = Location();
    var permissionGranted = await locationPlugin.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationPlugin.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return emit(
          state.copyWith(
            location: _kInitialLocation,
            loading: false,
          ),
        );
      }
    }
    final locationData = await locationPlugin.getLocation();
    final userLocation = LatLng(
      locationData.latitude!,
      locationData.longitude!,
    );
    emit(
      state.copyWith(
        location: userLocation,
        loading: false,
      ),
    );
  }
}
