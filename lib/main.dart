import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_tracker/auth/auth_screen.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/cubit/cubit.dart';

import 'const/myBlocObserver.dart';
import 'layout/layout.dart';
import 'network/local/cash_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  uId = CacheHelper.getData(key: 'uid');
  Widget startWidget;
  if (uId == null) {
    startWidget = AuthScreen();
  } else {
    startWidget = LayoutScreen();
  }
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MedCubit()..getUserData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Parking Finder',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: AppColors.primColor,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              titleTextStyle: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            textTheme: TextTheme(
              headline1: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0,
                fontSize: 24,
              ),
              headline2: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                letterSpacing: 0.15,
                color: Colors.black,
              ),
              subtitle1: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
              bodyText1: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
              bodyText2: GoogleFonts.nunito(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
              caption: GoogleFonts.nunito(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.black,
              ),
              button: GoogleFonts.nunito(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.white,
              ),
              overline: GoogleFonts.nunito(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.primColor),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.primColor, // This is a custom color variable
                textStyle: GoogleFonts.nunito(),
              ),
            ),
          ),
          home: startWidget),
    );
  }
}
