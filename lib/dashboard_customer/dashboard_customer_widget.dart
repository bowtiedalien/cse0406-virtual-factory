import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_factory/components/product_card_widget.dart';
import 'package:virtual_factory/db/database.dart';
import 'package:virtual_factory/model/order.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardCustomerWidget extends StatefulWidget {
  DashboardCustomerWidget({Key? key}) : super(key: key);

  @override
  _DashboardCustomerWidgetState createState() =>
      _DashboardCustomerWidgetState();
}

class _DashboardCustomerWidgetState extends State<DashboardCustomerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Future<Order> addOrderToBasket(Order order) {
      var val = VirtualFactory.instance.createOrder(order);
      print('Order added to basket!');
      return val;
    }

    TextEditingController _dateFieldController = TextEditingController();

    Future<void> _displayTextInputDialog(BuildContext context) async {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Pick a deadline for this order'),
            content: TextField(
              keyboardType: TextInputType.datetime,
              controller: _dateFieldController,
              onTap: () async {
                FocusScope.of(context).requestFocus(
                    new FocusNode()); //stop keyboard from appearing

                // show datepicker
                DateTime? date = DateTime(2021);

                date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2022),
                );
                _dateFieldController.text = date.toString().substring(0, 10);
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () async {
                  var order = new Order(
                    customerId: 10,
                    orderDate: DateTime.now(),
                    deadline: DateTime.parse(_dateFieldController.text),
                    status: enumOrderStatus.unconfirmed.toString(),
                  );
                  await addOrderToBasket(order);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppBar(
          backgroundColor: Color(0xFF007ED8),
          automaticallyImplyLeading: false,
          title: Text(
            'Virtual Factory',
            style: FlutterFlowTheme.title2.override(
              fontFamily: 'Poppins',
              color: FlutterFlowTheme.tertiaryColor,
            ),
          ),
          actions: [],
          elevation: 4,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              ProductCardWidget(
                category: 'Computer parts',
                productId: 1,
                productImagePath:
                    'https://www.bestelectricalsupplies.co.uk/ekmps/shops/bestelectrical/images/bnet61m-1m-cat6-network-cable-black-1827-p.png',
                cardTitle: 'AmazonBasics Ehernet cable - black',
                icon: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.plusCircle,
                    size: 35,
                    color: Colors.green,
                  ),
                  onPressed: () async {
                    await _displayTextInputDialog(context);
                  },
                ),
              ),
              ProductCardWidget(
                category: 'Computer Parts',
                productId: 2,
                productImagePath:
                    'http://www.bestdeal4u.com.au/assets/full/353179.png?20200717030650',
                cardTitle: 'Rex Ethernet cable - yellow',
                icon: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.plusCircle,
                    size: 35,
                    color: Colors.green,
                  ),
                  onPressed: () async {
                    await _displayTextInputDialog(context);
                  },
                ),
              ),
              ProductCardWidget(
                category: 'Computer Parts',
                productId: 3,
                productImagePath:
                    'https://medias.pylones.com/img/p/4/8/5/6/4856-large_default.jpg',
                cardTitle: 'Rex USB cable - red',
                icon: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.plusCircle,
                    size: 35,
                    color: Colors.green,
                  ),
                  onPressed: () async {
                    await _displayTextInputDialog(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
