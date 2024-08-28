import 'package:bank_loan/core/util/network/service_locator.dart';
import 'package:bank_loan/splash_screen.dart';
import 'package:flutter/material.dart';
import 'bloc_observer.dart';
import 'core/util/screen_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/loan_page/presentation/manger/loan_cubit.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.initSize(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF004F9F),
        ),
        fontFamily: 'Almarai',
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        appBarTheme: AppBarTheme(backgroundColor: const Color(0xFFF7F7F7),)
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) => LoanCubit(),
          child:  easySplash(),
        ),
      ),
    );
  }
}