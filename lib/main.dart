import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './bloc/application_bloc.dart';
import './repository/app_service.dart';
import './screen/home_screen.dart';
import './screen/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ),
  );
  return runApp(
    Provider<ApplicationBloc>(
      create: (_){
        return ApplicationBloc();
      },
      dispose: (_, value){
        value?.dispose();
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ApplicationBloc>(context);
    return StreamBuilder<int>(
      stream: bloc.streamTheme,
      builder: (_, snapshot){
        return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [const Locale('pt', 'BR'),],
          debugShowCheckedModeBanner: false,
          theme: bloc.getThemeData(snapshot.data),
          navigatorKey: AppService.instance.navigatorKey,
          home: SplashScreen(
            onInitializationComplete: (){
              AppService.instance.navigatePushReplecementTo(HomeScreen(), animated: true);
            },
          ),
        );
      },
    );
  }
}