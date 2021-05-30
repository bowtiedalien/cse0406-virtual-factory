final String tableOrders = 'orders';
enum enumOrderStatus { unconfirmed, delivered, scheduled }

class OrderFields {
  // Table Columns
  static final List<String> values = [id, customerId, orderDate, deadline];
  static final String id = '_id';
  static final String customerId = 'customer_id';
  static final String orderDate = 'order_date';
  static final String deadline = 'deadline';
  static final String status = 'status';
}

class Order {
  final int? id;
  final int customerId;
  final DateTime orderDate;
  final DateTime deadline;
  final String? status;

  const Order(
      {this.id,
      required this.customerId,
      required this.orderDate,
      required this.deadline,
      this.status});

  Order copy(
          {int? id,
          int? customerId,
          DateTime? orderDate,
          DateTime? deadline,
          String? status}) =>
      Order(
          id: id ?? this.id,
          customerId: customerId ?? this.customerId,
          orderDate: orderDate ?? this.orderDate,
          deadline: deadline ?? this.deadline,
          status: status ?? this.status);

  Map<String, Object?> toJson() => {
        OrderFields.id: id,
        OrderFields.customerId: customerId,
        OrderFields.orderDate: orderDate.toIso8601String(),
        OrderFields.deadline: deadline.toIso8601String(),
        OrderFields.status: status,
      };

  static Order fromJson(Map<String, Object?> json) => Order(
        id: json[OrderFields.id] as int?,
        customerId: json[OrderFields.customerId] as int,
        orderDate: DateTime.parse(json[OrderFields.orderDate] as String),
        deadline: DateTime.parse(json[OrderFields.deadline] as String),
        status: json[OrderFields.status] as String?,
      );
}
