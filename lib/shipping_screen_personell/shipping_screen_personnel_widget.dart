import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingScreenPersonnelWidget extends StatefulWidget {
  ShippingScreenPersonnelWidget({Key? key}) : super(key: key);

  @override
  _ShippingScreenPersonnelWidgetState createState() =>
      _ShippingScreenPersonnelWidgetState();
}

class _ShippingScreenPersonnelWidgetState
    extends State<ShippingScreenPersonnelWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFE26523),
        automaticallyImplyLeading: false,
        title: Text(
          'Shipping',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.tertiaryColor,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        child: Text(
          'No orders put to shipping yet',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
