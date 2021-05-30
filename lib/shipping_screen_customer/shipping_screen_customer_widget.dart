import 'package:virtual_factory/components/order_card_widget.dart';
import 'package:virtual_factory/db/database.dart';
import 'package:virtual_factory/model/order.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingScreenCustomerWidget extends StatefulWidget {
  ShippingScreenCustomerWidget({Key? key}) : super(key: key);

  @override
  _ShippingScreenCustomerWidgetState createState() =>
      _ShippingScreenCustomerWidgetState();
}

class _ShippingScreenCustomerWidgetState
    extends State<ShippingScreenCustomerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<Order> orders = List.empty();

  @override
  void initState() {
    super.initState();

    refreshOrders();
  }

  Future refreshOrders() async {
    setState(() => isLoading = true);
    print(isLoading);

    this.orders = await VirtualFactory.instance.getConfirmedOrders();

    setState(() => isLoading = false);
    print(isLoading);
    print(orders.length);
    print(orders.isEmpty);
    print(orders);
  }

  Future<int> deleteOrder(int id) async {
    var deletedId = await VirtualFactory.instance.deleteOrder(id);
    print('deleted one order');
    await refreshOrders();
    return deletedId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Shipping - My Orders',
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
              : orders.isEmpty
                  ? Container(
                      child: Text(
                        'No orders confirmed yet',
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListView.builder(
                      //TODO: this should be products not orders - maybe later after submission
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
                              orders[index].orderDate.toString().split(" ")[0],
                          icon: IconButton(
                            icon: Icon(Icons.delete_sweep_rounded),
                            onPressed: () async {
                              await deleteOrder(orders[index].id!);
                            },
                          ),
                        );
                      })),
    );
  }
}
