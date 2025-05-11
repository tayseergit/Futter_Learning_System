class AddressResponse {
  final String message;
  final List<Address> data;

  AddressResponse({
    required this.message,
    required this.data,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      message: json['message'],
      data: (json['data'] as List)
          .map((addressJson) => Address.fromJson(addressJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((address) => address.toJson()).toList(),
    };
  }
}

class Address {
  final int id;
  final dynamic name;
  final dynamic city;
  final dynamic region;
  final dynamic details;
  final double lon;
  final double lat;
  final dynamic notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Address({
    required this.id,
    required this.name,
    required this.city,
    required this.region,
    required this.details,
    required this.lon,
    required this.lat,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      region: json['region'],
      details: json['details'],
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'region': region,
      'details': details,
      'lon': lon,
      'lat': lat,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
