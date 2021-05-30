import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_factory/control_panel.dart';
import 'package:virtual_factory/login_portal/login_portal_widget.dart';
import 'package:virtual_factory/orders_personnel/orders_personnel_widget.dart';
import 'package:virtual_factory/personnel_login/personnel_login_widget.dart';
import 'package:virtual_factory/shipping_screen_personell/shipping_screen_personnel_widget.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonnelNavBar extends StatefulWidget {
  PersonnelNavBar({Key? key, this.initialPage, required this.isLoggedIn})
      : super(key: key);

  final String? initialPage;
  bool isLoggedIn;

  @override
  _PersonnelNavBarState createState() => _PersonnelNavBarState();
}

class _PersonnelNavBarState extends State<PersonnelNavBar> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentPage = 'Dashboard_Personnel';
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
      'Dashboard_Personnel': DashboardPersonnelWidget(),
      'BasketScreen_Personnel': OrdersPersonnelWidget(),
      'ShippingScreen_Personnel': ShippingScreenPersonnelWidget(),
      'LoginPortal': isLoggedIn
          ? PersonnelLoginWidget(loggedIn: true)
          : LoginPortalWidget(),
    };
    return Scaffold(
      key: scaffoldKey,
      body: tabs[_currentPage],
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Control Panel')),
            ListTile(
              title: TextButton(
                  child: Text('Control Panel'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ControlPanel()));
                  }),
            ),
          ],
        ),
      ),
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
              FontAwesomeIcons.boxOpen,
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

class DashboardPersonnelWidget extends StatefulWidget {
  @override
  _DashboardPersonnelWidgetState createState() =>
      _DashboardPersonnelWidgetState();
}

class _DashboardPersonnelWidgetState extends State<DashboardPersonnelWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE26523),
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }),
        title: Text(
          'Dashboard - Personnel',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
    );
  }
}
