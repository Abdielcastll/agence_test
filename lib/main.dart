import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/app/data/data_source/local/local_data_repository.dart';
import 'package:test_app/app/view/_components/no_scale_widget/no_scale_widget.dart';
import 'package:test_app/app/view/app_router.dart';
import 'package:test_app/config/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDataRepository().initPrefs();
  await Firebase.initializeApp();
  await ServiceLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      title: 'Agence app',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.initialPage,
      navigatorObservers: [_ClearFocusOnPush()],
      onGenerateRoute: AppRouter.generateRoute,
      builder: (_, child) {
        return NoScaleTextWidget(child: child!);
      },
    );
  }
}

class _ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}
