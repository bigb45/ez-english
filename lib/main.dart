// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:ez_english/firebase_options.dart';
import 'package:ez_english/resources/app_strings.dart';
import 'package:ez_english/theme/palette.dart';
import 'package:ez_english/widgets/button.dart';
import 'package:ez_english/widgets/card.dart';
import 'package:ez_english/widgets/result_card.dart';
import 'package:ez_english/widgets/text_field.dart';
import 'package:ez_english/widgets/word_chip.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
        Locale('tr'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale('en'));
    return
        // AppProviders(
        //   child:
        ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, child) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'EZ English',
        theme: ThemeData(
          primaryColor: Palette.primary,
          scaffoldBackgroundColor: Palette.secondary,
        ),
        home: const Components(),
      ),
      // ),
    );
  }
}

class Components extends StatelessWidget {
  const Components({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                onPressed: () {},
                type: ButtonType.primary,
                child: Text(
                  AppStrings.continueButton,
                  style: TextStyle(
                    color: Palette.secondary,
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextField(),
              SizedBox(height: 20.h),
              SelectableCard(
                onPressed: () {},
                child: Text(
                  "Long Vocabulary Card",
                  style: TextStyle(
                    color: Palette.primaryText,
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              WordChip(
                onPressed: () {},
                child: Text(
                  "word",
                  style: TextStyle(
                    color: Palette.primaryText,
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              ResultCard(
                topText: "BAD",
                score: Score.bad,
                mainText: "8/10 ANSWERED CORRECTLY",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
