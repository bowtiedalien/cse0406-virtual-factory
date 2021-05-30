import 'package:virtual_factory/model/order.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCardWidget extends StatefulWidget {
  OrderCardWidget({
    Key? key,
    required this.orderId,
    required this.customerId,
    required this.orderStatus,
    required this.orderDate,
    this.icon,
  }) : super(key: key);

  final String orderId;
  final String customerId;
  final String orderDate;
  final String orderStatus;
  final Widget? icon;

  @override
  _OrderCardWidgetState createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              'cus id: ' + widget.customerId,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Order #: ' + widget.orderId,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    (widget.orderStatus == enumOrderStatus.scheduled)
                        ? 'scheduled on ' + widget.orderDate
                        : widget.orderStatus.toString(),
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ],
              ),
            ),
          ),
          widget.icon != null
              ? Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: widget.icon,
                )
              : Container(),
        ],
      ),
    );
  }
}
