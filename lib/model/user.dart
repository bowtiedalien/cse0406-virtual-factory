final String tableUsers = 'users';

class UserFields {
  // Table Columns
  static final List<String> values = [id, name, password];

  static final String id = '_id';
  static final String name = 'name';
  static final String password = 'password';
}

class User {
  final int? id;
  final String name;
  final String password;

  const User({required this.id, required this.name, required this.password});

  User copy({
    int? id,
    String? name,
    String? password,
  }) =>
      User(
          id: id ?? this.id,
          name: name ?? this.name,
          password: password ?? this.password);

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.password: password,
      };

  static User fromJson(Map<String, Object?> json) => User(
        id: json[UserFields.id] as int?,
        name: json[UserFields.name] as String,
        password: json[UserFields.password] as String,
      );
}
