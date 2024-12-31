import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:my_priest/pages/Account.dart';

import 'package:my_priest/pages/splash_screen.dart';
import 'package:provider/provider.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';
import 'pages/Temples.dart';
import 'pages/my_account/myaccount.dart';
import 'pages/my_bookings/booking_details_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });
      

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (_) => Servicedetailsdata()),
        //  ChangeNotifierProvider(create: (_) => Templedetails()),
        ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'myPriest',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', '')],
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: false,
        ),
      
        themeMode: _themeMode,
        home: splash(),
      ),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  @override
  void initState() {
    super.initState();
//      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
// OneSignal.initialize();
// OneSignal.Notifications.requestPermission(true).then((value) {
//       print('signal value: $value');
//     }
//  );
  }
   final List<int> _navigationHistory = [0]; 
  Future<bool> _onWillPop() async {
    if (_navigationHistory.length > 1) {
      setState(() {
        _navigationHistory.removeLast();
        currentindex = _navigationHistory.last;
      });
      return false; // Prevent exiting the app
    }
    return true; // Exit the app
  }
 void _onTabTapped(int index) {
    if (currentindex != index) {
      setState(() {
        _navigationHistory.add(index);
        currentindex = index;
      });
    }
  }
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: currentindex,
          children: [
            HomePageWidget(),
            ServicesWidget(),
            TemplesWidget(),
            myaccount(),
          ],
        ),
        bottomNavigationBar:
        
        CustomLineIndicatorBottomNavbar(
          selectedColor: Colors.white,
          splashColor: Colors.white,
          unSelectedColor: Colors.white,
          backgroundColor:Color.fromARGB(255, 214, 98, 35),
          currentIndex: currentindex,
          unselectedIconSize: 20,
          selectedIconSize: 20,
          onTap: _onTabTapped,
          enableLineIndicator: true,
          lineIndicatorWidth: 3,
          indicatorType: IndicatorType.bottom,
          
          customBottomBarItems: [
            CustomBottomBarItems(
              label: 'Home',
              
              assetsImagePath: "assets/images/Vector (1).png",
              isAssetsImage: true,
            ),
            CustomBottomBarItems(
              label: 'Services',
              //icon: Icons.account_box_outlined,
              assetsImagePath: "assets/images/Group 2 (1).png",
              isAssetsImage: true,
            ),
            CustomBottomBarItems(
              label: 'Temples',
              
              assetsImagePath: "assets/images/Group (3).png",
              isAssetsImage: true,
            ),
            CustomBottomBarItems(
              label: 'Account',
              
              assetsImagePath: "assets/images/Group 3.png",
              isAssetsImage: true,
            ),
            
          ],
        ),
        //  BottomNavigationBar(
        //   currentIndex: currentindex,
        //   onTap: (i) async {
        //     setState(() {
        //       currentindex=i;
        //     });
        //   },
        //   backgroundColor: Color.fromARGB(255, 214, 98, 35),
        //   selectedItemColor: Colors.white,
        //   unselectedItemColor: Colors.white,
        //   // showSelectedLabels: false,
        //   // showUnselectedLabels: false,
        //   type: BottomNavigationBarType.fixed,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Image.asset("assets/images/Vector (1).png",height: 20,),
        //       label: 'Home',
             
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Image.asset("assets/images/Group 2 (1).png",height: 20,),
        //       label: 'Services',
              
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Image.asset("assets/images/Group (3).png",height: 20,),
        //       label: 'Temples',
              
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Image.asset("assets/images/Group 3.png",height: 20,),
        //       label: 'Account',
              
        //     )
        //   ],
        // ),
      ),
    );
  }
}
