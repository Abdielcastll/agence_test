import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:test_app/app/domain/model/products.dart';
import 'package:test_app/app/view/_components/my_button/my_button.dart';
import 'package:test_app/app/view/_components/my_spacer/my_spacer.dart';
import 'package:test_app/app/view/product/bloc/product_cubit.dart';
import 'package:test_app/app/view/product/bloc/product_state.dart';
import 'package:test_app/app/view/theme/text_style.dart';

class ProductPage extends StatelessWidget {
  const ProductPage._();

  static const String route = '/product_page';

  static Widget create(Products product) {
    return BlocProvider(
      create: (context) => ProductCubit(product),
      child: const ProductPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cubit.state.product?.name ?? '',
          style: AppTextStyle.h2Style.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              const _Map(),
              Expanded(
                child: _ProductDescription(state.product!),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: MyButton(
                  onPressed: () async {
                    _confirm(context).then((v) {
                      if (v!) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Compra Exitosa!',
                            textAlign: TextAlign.center,
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(20),
                        ));
                      }
                    });
                  },
                  text: 'Comprar',
                  width: double.infinity,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<bool?> _confirm(BuildContext context) {
    return showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('¿Desea confirmar su compra?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('NO')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('SI'))
          ],
        );
      },
    );
  }
}

class _Map extends StatefulWidget {
  const _Map({
    Key? key,
  }) : super(key: key);

  @override
  State<_Map> createState() => _MapState();
}

class _MapState extends State<_Map> {
  static const String accessToken =
      'sk.eyJ1IjoiYWJkaWVsY2FzdGxsIiwiYSI6ImNsZ2JjajB1MjAzemwzamxucXpjM2xrMjAifQ.7hl0kbOtMwMWTGgUGcG2iQ';

  @override
  void initState() {
    context.read<ProductCubit>().requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return SizedBox(
          height: size.height * 1 / 3,
          child: state.loading
              ? const Center(child: CircularProgressIndicator())
              : FlutterMap(
                  options: MapOptions(
                      center: state.location,
                      maxZoom: 25,
                      minZoom: 5,
                      zoom: 18),
                  nonRotatedChildren: [
                    TileLayer(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                      additionalOptions: const {
                        'accessToken': accessToken,
                        'id': 'mapbox/streets-v12'
                      },
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: state.location!,
                          builder: (context) {
                            return const Icon(
                              Icons.location_pin,
                              color: Colors.blue,
                              size: 40,
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
        );
      },
    );
  }
}

class _ProductDescription extends StatelessWidget {
  const _ProductDescription(this.product);

  final Products product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
              child: Image.asset(
            product.image,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    product.name,
                    style: AppTextStyle.h3Style,
                  ),
                  spacerS,
                  Expanded(child: Text(product.description)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
