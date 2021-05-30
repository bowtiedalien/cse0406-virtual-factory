import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreenPersonnelWidget extends StatefulWidget {
  ProfileScreenPersonnelWidget({Key? key}) : super(key: key);

  @override
  _ProfileScreenPersonnelWidgetState createState() =>
      _ProfileScreenPersonnelWidgetState();
}

class _ProfileScreenPersonnelWidgetState
    extends State<ProfileScreenPersonnelWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFE26523),
        automaticallyImplyLeading: false,
        title: Text(
          'My Account',
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
