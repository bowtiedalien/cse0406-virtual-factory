import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_factory/components/order_card_widget.dart';
import 'package:virtual_factory/db/database.dart';
import 'package:virtual_factory/model/order.dart';

import '../components/product_card_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BasketScreenCustomerWidget extends StatefulWidget {
  BasketScreenCustomerWidget({Key? key}) : super(key: key);

  @override
  _BasketScreenCustomerWidgetState createState() =>
      _BasketScreenCustomerWidgetState();
}

class _BasketScreenCustomerWidgetState
    extends State<BasketScreenCustomerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<Order> orders = List.empty();

  @override
  void initState() {
    super.initState();

    refreshBasket();
  }

  Future refreshBasket() async {
    setState(() => isLoading = true);
    print(isLoading);

    this.orders = await VirtualFactory.instance.getUnconfirmedOrders();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Future<int> confirmOrderStatus(Order order) async {
      final updatedOrder =
          await VirtualFactory.instance.updateOrderStatus(order);
      print('confirmed order!');
      return updatedOrder;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'My Basket',
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
                    //TODO: this should be products not orders - maybe later after submission
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      // converting status from String to enumOrderStatus
                      enumOrderStatus orderStat = enumOrderStatus.values
                          .firstWhere(
                              (e) => e.toString() == orders[index].status,
                              orElse: () => enumOrderStatus.unconfirmed);
                      return Column(
                        children: [
                          OrderCardWidget(
                            orderId: orders[index].id.toString(),
                            customerId: orders[index].customerId.toString(),
                            orderStatus: orders[index].status!.split('.')[1],
                            orderDate: orders[index]
                                .orderDate
                                .toString()
                                .split(" ")[0],
                            icon: Icon(Icons.delete_sweep_rounded),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              var order = new Order(
                                  id: orders[index].id,
                                  customerId: orders[index].customerId,
                                  status: enumOrderStatus.scheduled.toString(),
                                  orderDate: DateTime.now(),
                                  deadline: orders[index].deadline);
                              await confirmOrderStatus(order);
                              await refreshBasket();
                            },
                            child: Text('Confirm'),
                          ),
                        ],
                      );
                    })
                : Container(
                    child: Text('No orders in the orders list',
                        style: TextStyle(fontSize: 24)),
                  ),
      ),
    );
  }
}
