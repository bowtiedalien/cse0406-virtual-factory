import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardWidget extends StatefulWidget {
  ProductCardWidget({
    Key? key,
    required this.cardTitle,
    required this.category,
    required this.productId,
    required this.productImagePath,
    required this.icon,
  }) : super(key: key);

  final String cardTitle;
  final String category;
  final int productId;
  final String productImagePath;
  final Widget icon;

  @override
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.productImagePath,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.cardTitle,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Poppins',
                      fontSize: 19,
                    ),
                  ),
                  Text(
                    widget.category,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
            child: widget.icon,
          )
        ],
      ),
    );
  }
}
