class User {
  String name;
  String email;
  String role;
  final int id;
  DateTime createdAt;
  String status;
  bool selected;

  User({
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.id,
    this.selected = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['username'],
      email: json['email'],
      role: json['role'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  @override
  String toString() {
    return 'User(id: $id, username: $name, email: $email,role:$role,status:$status,created_at:$createdAt)';
  }
}
