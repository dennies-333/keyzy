class Visitor {
  final String visitorId;
  final String tenantId;
  final String name;
  final String relationship;
  final DateTime timestamp;

  Visitor({
    required this.visitorId,
    required this.tenantId,
    required this.name,
    required this.relationship,
    required this.timestamp,
  });

  // Factory method to create a Visitor from a JSON map
  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      visitorId: json['visitorId'] ?? '',
      tenantId: json['tenantId'] ?? '',
      name: json['name'] ?? '',
      relationship: json['relationship'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }

  // Convert a Visitor to JSON (useful if you need to send data to the API)
  Map<String, dynamic> toJson() {
    return {
      'visitorId': visitorId,
      'tenantId': tenantId,
      'name': name,
      'relationship': relationship,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
