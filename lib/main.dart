import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scorers_assignment/business/bloc/authentication/authentication_bloc.dart';
import 'package:scorers_assignment/business/bloc/profile/profile_bloc.dart';
import 'package:scorers_assignment/presentation/routers/router_constant.dart';
import 'package:scorers_assignment/utility/constant.dart';

import 'business/observer/simple_observer.dart';
import 'presentation/routers/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  if(kDebugMode){
    await dotenv.load(fileName: ".env_example");
  }else{
    await dotenv.load(fileName: ".env");
  }
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
              color: appbarBackgroundColor
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: RouterConstant.HomePage,
      ),
    );
  }
}