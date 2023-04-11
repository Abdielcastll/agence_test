import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/domain/repository/auth_repository.dart';
import 'package:test_app/app/domain/value_object/status.dart';
import 'package:test_app/app/view/_components/my_button/my_button.dart';
import 'package:test_app/app/view/_components/my_input/my_input.dart';
import 'package:test_app/app/view/_components/my_spacer/my_spacer.dart';
import 'package:test_app/app/view/_components/tap_to_hide_keyboard/tap_to_hide_keyboard.dart';
import 'package:test_app/app/view/home/home_page.dart';
import 'package:test_app/app/view/login/bloc/login_cubit.dart';
import 'package:test_app/app/view/login/bloc/login_state.dart';
import 'package:test_app/app/view/theme/button_style.dart';
import 'package:test_app/app/view/theme/text_style.dart';
import 'package:test_app/config/service_locator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();

  static const String route = '/login';

  static Widget create() {
    return BlocProvider(
      create: (context) => LoginCubit(
        getIt<AuthRepository>(),
      ),
      child: const LoginPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return MyTapToHideKeyboard(
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == FormStatus.done) {
              Navigator.pushReplacementNamed(context, HomePage.route);
            }
          },
          builder: (context, state) {
            if (state.loadingLogin) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const MySpacer(height: 90),
                  const Text(
                    'Iniciar sesión',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.h1Style,
                  ),
                  const MySpacer(height: 40),
                  Visibility(
                    visible: state.status == FormStatus.error,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.msgError ??
                            'El correo electrónico o la contraseña son incorrectos. Inténtalo de nuevo.',
                        style: AppTextStyle.msgError,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  MyInput(
                    label: 'E-mail',
                    hintText: 'Escribe tu correo electrónico',
                    onChanged: cubit.email,
                    inputType: TextInputType.emailAddress,
                    hasError: state.status == FormStatus.error,
                  ),
                  spacerS,
                  MyInput(
                    label: 'Contraseña',
                    hintText: 'Escribe tu contraseña',
                    hideInput: true,
                    onChanged: cubit.password,
                    hasError: state.status == FormStatus.error,
                  ),
                  MyButton(
                    onPressed: () {},
                    text: 'He olvidado mi contraseña',
                    variant: MyButtonVariant.containedSecondary,
                  ),
                  spacerS,
                  MyButton(
                    onPressed: cubit.login,
                    text: 'Iniciar sesión',
                    isLoading: state.status == FormStatus.loading,
                    disabled: !state.isComplete,
                  ),
                  spacerS,
                  MyButton(
                    onPressed: () {},
                    text: 'Aún no tengo cuenta',
                  ),
                  spacerM,
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        thickness: 2,
                      )),
                      spacerS,
                      Text('o continúa con'),
                      spacerS,
                      Expanded(child: Divider(thickness: 2)),
                    ],
                  ),
                  spacerS,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: GoogleAuthButton(
                      onPressed: cubit.loginGoogle,
                      themeMode: ThemeMode.light,
                      style: const AuthButtonStyle(
                        buttonType: AuthButtonType.icon,
                      ),
                    ),
                  ),
                  spacerS,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FacebookAuthButton(
                      onPressed: cubit.loginFacebook,
                      themeMode: ThemeMode.light,
                      style: const AuthButtonStyle(
                        buttonType: AuthButtonType.icon,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
