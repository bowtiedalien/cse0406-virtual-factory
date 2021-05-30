import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreenCutomerWidget extends StatefulWidget {
  ProfileScreenCutomerWidget({Key? key}) : super(key: key);

  @override
  _ProfileScreenCutomerWidgetState createState() =>
      _ProfileScreenCutomerWidgetState();
}

class _ProfileScreenCutomerWidgetState
    extends State<ProfileScreenCutomerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'My Account',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: Color(0xFFF9F4F4),
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
    );
  }
}
