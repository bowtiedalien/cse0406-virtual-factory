import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_factory/customer_login/customer_login_widget.dart';
import 'package:virtual_factory/dashboard_customer/dashboard_customer_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_factory/dashboard_personnel/dashboard_personnel_widget.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'dashboard_customer/dashboard_customer_widget.dart';
import 'basket_screen_customer/basket_screen_customer_widget.dart';
import 'shipping_screen_customer/shipping_screen_customer_widget.dart';
import 'login_portal/login_portal_widget.dart';

void main() {
  runApp(MyApp(mode: "Customer"));
}

class MyApp extends StatefulWidget {
  final String mode;

  MyApp({required this.mode});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    Future<void> getLoggedIn() async {
      SharedPreferences prefs = await _prefs;
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    }

    getLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VirtualFactory',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: widget.mode == "Customer"
          ? NavBarPage(
              initialPage: 'Dashboard_Customer',
              isLoggedIn: isLoggedIn,
            )
          : PersonnelNavBar(
              initialPage: 'Dashboard_Personnel',
              isLoggedIn: isLoggedIn,
            ),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, required this.isLoggedIn})
      : super(key: key);

  final String? initialPage;
  bool isLoggedIn;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'Dashboard_Customer';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;

    Future<void> getLoggedIn() async {
      SharedPreferences prefs = await _prefs;
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    }

    getLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Dashboard_Customer': DashboardCustomerWidget(),
      'BasketScreen_Customer': BasketScreenCustomerWidget(),
      'ShippingScreen_Customer': ShippingScreenCustomerWidget(),
      'LoginPortal': isLoggedIn
          ? CustomerLoginWidget(
              loggedIn: true,
            )
          : LoginPortalWidget(),
    };
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.home,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.shoppingBasket,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.shippingFast,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.userAlt,
              size: 24,
            ),
            label: 'Home',
          )
        ],
        backgroundColor: Colors.white,
        currentIndex: tabs.keys.toList().indexOf(_currentPage),
        selectedItemColor: Color(0xFF007ED8),
        unselectedItemColor: Color(0x8A000000),
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
