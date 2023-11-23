import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:firenotes/app/utils/styles.dart';

import 'app/modules/splash_screen/splash_screen.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth auth = FirebaseAuth.instance;

  await GetStorage.init();

  runApp(
    StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        return GetMaterialApp(
          title: "Firenotes",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
            scaffoldBackgroundColor: primaryColor,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: primaryColor,
              centerTitle: true,
              foregroundColor: darkBlackColor,
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: formTextStyle.copyWith(
                color: lightBlackColor.withOpacity(0.3),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 19,
                horizontal: 16,
              ),
              filled: true,
              fillColor: whiteColor,
            ),
          ),
          initialRoute:
              snapshot.data != null && snapshot.data!.emailVerified == true
                  ? Routes.home
                  : Routes.login,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
