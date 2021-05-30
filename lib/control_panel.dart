import 'package:flutter/material.dart';
import 'package:virtual_factory/db/database.dart';

import 'model/order.dart';

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  List<Order> allOrders = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Future<Order> addTestOrder() async {
      Order order = new Order(
          customerId: 1,
          orderDate: DateTime.now(),
          deadline: DateTime.now(),
          status: enumOrderStatus.delivered.toString());
      order = await VirtualFactory.instance.createOrder(order);
      print('Test order added!');
      return order;
    }

    Future<int> showOrders() async {
      setState(() => isLoading = true);

      allOrders = await VirtualFactory.instance.getAllOrders();
      print('Fetching orders ...');

      setState(() => isLoading = false);

      if (allOrders.isNotEmpty) {
        print('Orders found!');
        print(allOrders);
        return 1;
      } else {
        print('No orders were found');
        return 0;
      }
    }

    Future<int> deleteOrder(int id) async {
      var deletedId = await VirtualFactory.instance.deleteOrder(id);
      print('deleted one order');
      await showOrders();
      return deletedId;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Control Panel'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(
                    'Add New Order',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () async {
                    await addTestOrder();
                  },
                ),
                ElevatedButton(
                  child: Text(
                    'Get all Orders',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () async {
                    await showOrders();
                  },
                ),
                Container(
                  width: 200,
                  height: 500,
                  child: allOrders.isNotEmpty
                      ? ListView.builder(
                          itemCount: allOrders.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                trailing: IconButton(
                                    icon: Icon(Icons.delete_sweep_rounded),
                                    onPressed: () async {
                                      await deleteOrder(allOrders[index].id!);
                                    }),
                                title: Text('Order id: ' +
                                    allOrders[index].id.toString() +
                                    ' \n' +
                                    'Customer id: ' +
                                    allOrders[index].customerId.toString() +
                                    ' \n' +
                                    'Order Date: ' +
                                    allOrders[index]
                                        .orderDate
                                        .toString()
                                        .split(' ')[0] +
                                    ' \n' +
                                    'Deadline: ' +
                                    allOrders[index]
                                        .deadline
                                        .toString()
                                        .split(' ')[0] +
                                    ' \n' +
                                    'Status: ' +
                                    allOrders[index]
                                        .status
                                        .toString()
                                        .split('.')[1]));
                          })
                      : Text('No orders were found'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
