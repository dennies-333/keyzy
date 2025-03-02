class TenantModel {
  String id;
  String username;
  String password;
  String role;
  String email;
  String phone;
  String address;
  String name;
  String unit_number;
  List<FamilyMember> familyMembers;
  List<Vehicle> vehicles;

  TenantModel({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    required this.email,
    required this.phone,
    required this.address,
    required this.name,
    required this.unit_number,
    required this.familyMembers,
    required this.vehicles,
  });

  // Factory method to create a TenantModel instance from a JSON object
  factory TenantModel.fromJson(Map<String, dynamic> json) {
    return TenantModel(
      id: json['id'], // updated from '_id' to 'id'
      username: json['username'],
      password: json['password'],
      role: json['role'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      name: json['name'],
      unit_number: json['unit_number'],
      familyMembers: (json['family_members'] as List)
          .map((item) => FamilyMember.fromJson(item))
          .toList(),
      vehicles: (json['vehicles'] as List)
          .map((item) => Vehicle.fromJson(item))
          .toList(),
    );
  }

  // Method to convert the TenantModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id, // updated to match JSON response
      'username': username,
      'password': password,
      'role': role,
      'email': email,
      'phone': phone,
      'address': address,
      'name': name,
      'unit_number': unit_number,
      'family_members': familyMembers.map((e) => e.toJson()).toList(),
      'vehicles': vehicles.map((e) => e.toJson()).toList(),
    };
  }
}

class FamilyMember {
  String firstName;
  String lastName;
  String relationship;

  FamilyMember({
    required this.firstName,
    required this.lastName,
    required this.relationship,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      firstName: json['first_name'],
      lastName: json['last_name'],
      relationship: json['relationship'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'relationship': relationship,
    };
  }
}

class Vehicle {
  String vehicleNumber;
  String vehicleType;
  String vehicleName;

  Vehicle({
    required this.vehicleNumber,
    required this.vehicleType,
    required this.vehicleName,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleNumber: json['vehicle_number'],
      vehicleType: json['vehicle_type'],
      vehicleName: json['vehicle_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle_number': vehicleNumber,
      'vehicle_type': vehicleType,
      'vehicle_name': vehicleName,
    };
  }
}
