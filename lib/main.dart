import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:passageiro/helper/notification_helper.dart';
import 'package:passageiro/helper/di_container.dart' as di;
import 'package:passageiro/helper/route_helper.dart';
import 'package:passageiro/localization/localization_controller.dart';
import 'package:passageiro/localization/messages.dart';
import 'package:passageiro/theme/dark_theme.dart';
import 'package:passageiro/theme/light_theme.dart';
import 'package:passageiro/theme/theme_controller.dart';
import 'package:passageiro/util/app_constants.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialização do Firebase com SUAS credenciais (projeto to-chegando-motoboy-24b4a)
  if (GetPlatform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDp58F_Sdf-CrcwUb8ZizIV7zCVEjIB1FI",
        appId: "1:491950036407:android:e1cdffd7cc7cd147034432",
        messagingSenderId: "491950036407",
        projectId: "to-chegando-motoboy-24b4a",
      ),
    );
  } else {
    // iOS, Web, etc. usam automaticamente o GoogleService-Info.plist
    await Firebase.initializeApp();
  }

  Map<String, Map<String, String>> languages = await di.init();
  final RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp(languages: languages, notificationData: remoteMessage?.data));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final Map<String, dynamic>? notificationData;

  const MyApp({super.key, required this.languages, this.notificationData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return SafeArea(
          top: false,
          child: GetMaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch
              },
            ),
            theme: themeController.darkTheme ? darkTheme : lightTheme,
            locale: localizeController.locale,
            initialRoute:
                RouteHelper.getSplashRoute(notificationData: notificationData),
            getPages: RouteHelper.routes,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                AppConstants.languages[0].countryCode),
            defaultTransition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 500),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(0.95)),
                child: child!,
              );
            },
          ),
        );
      });
    });
  }
}