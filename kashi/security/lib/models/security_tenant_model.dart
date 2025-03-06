class SecurityModel {
  String id;
  String email;
  String phone;
  String address;
  String name;
  String unitNumber;

  SecurityModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.address,
    required this.name,
    required this.unitNumber,
  });

  // Factory method to create a SecurityModel instance from JSON
  factory SecurityModel.fromJson(Map<String, dynamic> json) {
    return SecurityModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      name: json['name'] ?? '',
      unitNumber: json['unit_number'] ?? '',
    );
  }

  // Method to convert the SecurityModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'address': address,
      'name': name,
      'unit_number': unitNumber,
    };
  }
}
