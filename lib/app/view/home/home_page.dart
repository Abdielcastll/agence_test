import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/domain/model/products.dart';
import 'package:test_app/app/domain/repository/products_repositoyr.dart';
import 'package:test_app/app/view/_components/my_drawer/my_drawer.dart';
import 'package:test_app/app/view/_components/my_spacer/my_spacer.dart';
import 'package:test_app/app/view/home/bloc/home_cubit.dart';
import 'package:test_app/app/view/home/bloc/home_state.dart';
import 'package:test_app/app/view/product/product_page.dart';
import 'package:test_app/app/view/theme/text_style.dart';
import 'package:test_app/config/service_locator.dart';

class HomePage extends StatelessWidget {
  const HomePage._();
  static const route = '/home_page';

  static Widget create() {
    return BlocProvider(
      create: (context) => HomeCubit(
        getIt<ProductsRepository>(),
      ),
      child: const HomePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Products',
          style: AppTextStyle.h2Style.copyWith(color: Colors.white),
        ),
      ),
      drawer: const MyDrawer(),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Center(
            child: Wrap(
              runAlignment: WrapAlignment.spaceAround,
              runSpacing: 10,
              spacing: 10,
              children: state.products.map((e) => _ProductCard(e)).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard(this.product);

  final Products product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ProductPage.route,
        arguments: product,
      ),
      child: Card(
        color: Colors.grey[100],
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: size.width * .42,
          child: Column(children: [
            Image.asset(
              product.image,
              height: 120,
              width: size.width * .42,
              fit: BoxFit.cover,
            ),
            spacerXs,
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                product.name,
                style: AppTextStyle.inputLabelStyle,
              ),
            ),
            spacerXs,
          ]),
        ),
      ),
    );
  }
}
