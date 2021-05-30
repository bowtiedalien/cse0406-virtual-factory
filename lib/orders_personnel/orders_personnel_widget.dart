import 'package:virtual_factory/db/database.dart';
import 'package:virtual_factory/model/order.dart';

import '../components/order_card_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersPersonnelWidget extends StatefulWidget {
  OrdersPersonnelWidget({Key? key}) : super(key: key);

  @override
  _OrdersPersonnelWidgetState createState() => _OrdersPersonnelWidgetState();
}

class _OrdersPersonnelWidgetState extends State<OrdersPersonnelWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Order> orders;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshOrders();
  }

  Future refreshOrders() async {
    setState(() => isLoading = true);
    print(isLoading);

    this.orders = await VirtualFactory.instance.getAllOrders();

    setState(() => isLoading = false);
    print(isLoading);
    print(orders.length);
    print(orders.isEmpty);
    print(orders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFDA5D1B),
        automaticallyImplyLeading: false,
        title: Text(
          'All Orders',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.tertiaryColor,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : orders.isNotEmpty
                ? ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      // Converting status from String to enumOrderStatus
                      enumOrderStatus orderStat = enumOrderStatus.values
                          .firstWhere(
                              (e) => e.toString() == orders[index].status,
                              orElse: () => enumOrderStatus.unconfirmed);
                      return OrderCardWidget(
                          orderId: orders[index].id.toString(),
                          customerId: orders[index].customerId.toString(),
                          orderStatus: orders[index].status!.split('.')[1],
                          orderDate:
                              orders[index].orderDate.toString().split(" ")[0]);
                    })
                : Container(
                    child: Text('No orders in the orders list',
                        style: TextStyle(fontSize: 24)),
                  ),
      ),
    );
  }
}
