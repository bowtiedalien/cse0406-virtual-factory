final String tableProducts = 'products';

class ProductFields {
  // Table Columns
  static final String id = '_id';
  static final String name = 'name';
  static final String productType = 'productType';
  static final String isSalable = 'isSalable';
}

class Product {
  final int? id;
  final String name;
  final String productType;
  final bool isSalable;

  const Product(
      {required this.id,
      required this.name,
      required this.productType,
      required this.isSalable});

  Map<String, Object?> toJson() => {
        ProductFields.id: id,
        ProductFields.name: name,
        ProductFields.productType: productType,
        ProductFields.isSalable: isSalable ? 1 : 0,
      };
  static Product fromJson(Map<String, Object?> json) => Product(
        id: json[ProductFields.id] as int?,
        name: json[ProductFields.name] as String,
        productType: json[ProductFields.productType] as String,
        isSalable: json[ProductFields.isSalable] == 1,
      );
}
