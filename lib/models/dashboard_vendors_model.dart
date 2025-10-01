class Vendor {
  final int vendorId;
  String storeName;
  String storeDescription;
  bool isActive;
  String storeLogo;
  final DateTime createdAt;
  String username;
  String email;
  String status;
  String rating; // New field for store rating
  int pruductCount; // New field for product count
  int orderCount; // New field for order count
  int trustLevel;
  String phone;

  Vendor({
    required this.vendorId,
    required this.storeName,
    required this.storeDescription,
    required this.isActive,
    required this.storeLogo,
    required this.createdAt,
    required this.username,
    required this.email,
    required this.status,
    required this.rating,
    required this.pruductCount,
    required this.orderCount,
    required this.trustLevel,
    required this.phone,
  });
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
        vendorId: json['vendor_id'],
        storeName: json['store_name'],
        storeDescription: json['store_description'],
        isActive: json['is_active'],
        storeLogo: json['store_logo'],
        createdAt: DateTime.parse(json['created_at']),
        username: json['username'],
        email: json['email'],
        status: json['status'].trim(), // إزالة الفراغات الزائدة
        rating: (json['rating'] ?? 0.0),
        pruductCount: json['pruduct_count'] ?? 0,
        orderCount: json['order_count'] ?? 0,
        phone: json['phone'] ?? '',
        trustLevel: json['trust_level'] ?? 0);
  }
  Map<String, dynamic> toJson() {
    return {
      'vendor_id': vendorId,
      'store_name': storeName,
      'store_description': storeDescription,
      'is_active': isActive,
      'store_logo': storeLogo,
      'created_at': createdAt.toIso8601String(),
      'username': username,
      'email': email,
      'status': status,
      'rating': rating,
      'pruduct_count': pruductCount,
      'order_count': orderCount,
      'trust_level': trustLevel,
      'phone': phone,
    };
  }
}
