import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:asset_tracker/models/login/login_model.dart';
import 'package:asset_tracker/provider/app_theme_provider.dart';
import 'package:asset_tracker/resource/app_resource.dart';
import 'package:asset_tracker/screens/login/login_screen.dart';
import 'package:asset_tracker/screens/main_screen.dart';
import 'package:asset_tracker/screens/splash/splash_screen.dart';
import 'package:asset_tracker/utils/database_helper.dart';
import 'package:asset_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

/*final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,

    /// for dark mode
    seedColor: Colors.blue,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);*/

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 58, 80, 222),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 111, 129, 250),
);

class AssetHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = AssetHttpOverrides();
  // initialization SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Utils().setupLogging();
  runApp(ProviderScope(
    // override SharedPreferences provider with correct value
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: const AssetTrackerApp(),
  ));
}

class AssetTrackerApp extends ConsumerStatefulWidget {
  const AssetTrackerApp({super.key});

  @override
  ConsumerState<AssetTrackerApp> createState() => _AssetTrackerAppState();
}

class _AssetTrackerAppState extends ConsumerState<AssetTrackerApp> {
  late List<LoginModel> data;

  Future<bool> checkLoginState() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    data = await DatabaseHelper().queryAll();

    print('User LoginModel data: $data');
    if (data.isNotEmpty) {
      //Navigator.pushReplacementNamed(context, '/home');
      return true;
    }
    return false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ref.watch allows you to monitor changes and rebuild our widget if necessary
    final bool isDarkMode = ref.watch(appThemeProvider).getTheme();
    return MaterialApp(
      title: AppTexts.appName,
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light().copyWith(
        useMaterial3: true,
        //scaffoldBackgroundColor: Color.fromARGB(255, 145, 163, 122),
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(.5),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: GoogleFonts.latoTextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 14,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        /*appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.onPrimaryContainer,
          foregroundColor: kDarkColorScheme.primaryContainer,
        ),*/
        /*inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.greenAccent),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.amberAccent),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),*/
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer),
        ),
        textTheme: GoogleFonts.latoTextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 14,
          ),
        ),
      ),
      home: AnimatedSplashScreen.withScreenFunction(
        //duration: 3000,
        splash: const SplashScreen(),
        screenFunction: () async {
          // Your code here
          var dataExist = await checkLoginState();

          return dataExist
              ? MainScreen(
                  loginModel: data[0],
                )
              : const LoginScreen();
        },
        //nextScreen: content,
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
