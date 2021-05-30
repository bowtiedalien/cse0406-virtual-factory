final String tableCustomers = 'customers';

class CustomerFields {
  // Customer Table Columns
  static final List<String> values = [id, name, password];

  static final String id = '_id';
  static final String name = 'name';
  static final String password = 'password';
}

class Customer {
  final int? id;
  final String name;
  final String password;

  const Customer(
      {required this.id, required this.name, required this.password});

  Customer copy({
    int? id,
    String? name,
    String? password,
  }) =>
      Customer(
          id: id ?? this.id,
          name: name ?? this.name,
          password: password ?? this.password);

  Map<String, Object?> toJson() => {
        CustomerFields.id: id,
        CustomerFields.name: name,
        CustomerFields.password: password,
      };

  static Customer fromJson(Map<String, Object?> json) => Customer(
        id: json[CustomerFields.id] as int?,
        name: json[CustomerFields.name] as String,
        password: json[CustomerFields.password] as String,
      );
}
