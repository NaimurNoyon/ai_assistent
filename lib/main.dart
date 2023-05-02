import 'package:ai_assistent/home_screen.dart';
import 'package:ai_assistent/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late bool _seen;

  @override
  void initState() {
    super.initState();
    _checkIfSeen();
  }

  Future<void> _checkIfSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnBoarding()),
      );
    }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ProChat',
          theme: ThemeData(
            fontFamily: 'Poppins',
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
            future: _checkIfSeen(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (_seen) {
                  return const HomeScreen();
                } else {
                  return const OnBoarding();
                }
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
