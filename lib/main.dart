 
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:reward_center_kiosk/helpers/storage.dart';  
import 'package:reward_center_kiosk/route.dart';
import 'package:reward_center_kiosk/util/const.dart';
import 'package:reward_center_kiosk/util/translation.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // await AppSetting().initSetting();
  // await Firebase.initializeApp();
  // await ShowNotificationService.initialize();
  final Translate translationService = Translate();
  await translationService.loadTranslations();
  // NotificationService.initialize();
  var initialRoute = RouteName.member;
 
  runApp(MyApp(
      translationService: translationService, initialRoute: initialRoute
      ));
}

class MyApp extends StatelessWidget {
  final Translate translationService;
  final String initialRoute;
  const MyApp(
      {super.key,
      required this.translationService,
      required this.initialRoute});
 
  @override
  Widget build(BuildContext context) {
    // var box = Storage();
    // var lang = 'en';
    
    var pickLang = const Locale("en", "EN");
    // if (lang == 'km') {
    //   pickLang = const Locale("km", "KH");
    // } else {
    //   pickLang = const Locale("en", "US");
    // }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            initialRoute: initialRoute,
            supportedLocales: const [
              Locale("en", "US"),  
              Locale("zh", "CH"),  
              Locale("vi", "VN"),  
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: pickLang, 
            translations: translationService, 
            fallbackLocale: const Locale("en", "US"),  
            // theme: AppTheme.lightTheme,
            getPages: Routes.pages,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0), 
                ),
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}
