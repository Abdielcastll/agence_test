import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/domain/repository/auth_repository.dart';
import 'package:test_app/app/view/splash/bloc/splash_cubit.dart';
import 'package:test_app/app/view/splash/bloc/splash_state.dart';
import 'package:test_app/config/service_locator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage._({Key? key}) : super(key: key);

  static const String route = '/';

  static Widget create() {
    return BlocProvider(
      create: (context) => SplashCubit(
        getIt<AuthRepository>(),
      ),
      child: const SplashPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.route != null) {
            Navigator.pushReplacementNamed(context, state.route!);
          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue[300],
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 6,
              ),
            ),
          );
        },
      ),
    );
  }
}
