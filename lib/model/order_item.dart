final String tableOrderItems = 'orderitems';

class OrderItemFields {
  // Table Columns
  static final List<String> values = [id, orderId, productId, amount];
  static final String id = '_id';
  static final String orderId = 'order_id';
  static final String productId = 'product_id';
  static final String amount = 'amount';
}

class OrderItem {
  final int? id;
  final int orderId;
  final int productId;
  final int amount;

  const OrderItem(
      {required this.id,
      required this.orderId,
      required this.productId,
      required this.amount});

  OrderItem copy({int? id, int? orderId, int? productId, int? amount}) =>
      OrderItem(
          id: id ?? this.id,
          orderId: orderId ?? this.orderId,
          productId: productId ?? this.productId,
          amount: amount ?? this.amount);

  Map<String, Object?> toJson() => {
        OrderItemFields.id: id,
        OrderItemFields.orderId: orderId,
        OrderItemFields.productId: productId,
        OrderItemFields.amount: amount
      };

  static OrderItem fromJson(Map<String, Object?> json) => OrderItem(
        id: json[OrderItemFields.id] as int?,
        orderId: json[OrderItemFields.orderId] as int,
        productId: json[OrderItemFields.productId] as int,
        amount: json[OrderItemFields.amount] as int,
      );
}
