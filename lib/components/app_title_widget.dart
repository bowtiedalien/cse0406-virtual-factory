import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitleWidget extends StatefulWidget {
  AppTitleWidget({Key? key}) : super(key: key);

  @override
  _AppTitleWidgetState createState() => _AppTitleWidgetState();
}

class _AppTitleWidgetState extends State<AppTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'My Virtual Factory',
      style: FlutterFlowTheme.title1.override(
        fontFamily: 'Poppins',
        color: Colors.white,
      ),
    );
  }
}
