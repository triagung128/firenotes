import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'app/routes/app_pages.dart';
import 'app/modules/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth auth = FirebaseAuth.instance;

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
