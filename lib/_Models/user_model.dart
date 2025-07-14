class UserModel {
  final String id;
  final String skuId;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String profileImage;
  final String gender;
  final String dateOfBirth;
  final String address;
  final String countryCode;
  final String country;
  final bool isDeleted;
  final bool isBlocked;
  final String role;
  final String? deletionDate; // Nullable since it can be null
  final String status;
  final String lastIpAddress;
  final String deviceFingerprint;
  final String createdAt;
  final String updatedAt;
  final String accountStatus;

  UserModel({
    required this.id,
    required this.skuId,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    this.profileImage = '', // Default to empty string
    this.gender = '', // Default to empty string
    this.dateOfBirth = '', // Default to empty string
    this.address = '', // Default to empty string
    this.countryCode = '', // Default to empty string
    this.country = '', // Default to empty string
    this.isDeleted = false, // Default to false
    this.isBlocked = false, // Default to false
    this.role = 'user', // Default to 'user'
    this.deletionDate, // Nullable, no default
    this.status = 'active', // Default to 'active'
    this.lastIpAddress = '', // Default to empty string
    this.deviceFingerprint = '', // Default to empty string
    this.createdAt = '', // Default to empty string
    this.updatedAt = '', // Default to empty string
    this.accountStatus = 'active', // Default to 'active'
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['userId']?.toString() ?? '',
      skuId: json['skuId'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phoneNo'] ?? '',
      profileImage: json['profilePic'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      address: json['address'] ?? '',
      countryCode: json['countryCode'] ?? '',
      country: json['country'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      role: json['role'] ?? 'user',
      deletionDate: json['deletionDate'],
      status: json['status'] ?? 'active',
      lastIpAddress: json['lastIpAddress'] ?? '',
      deviceFingerprint: json['deviceFingerprint'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      accountStatus: json['accountStatus'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'skuId': skuId,
      'name': name,
      'username': username,
      'email': email,
      'phoneNo': phone,
      'profilePic': profileImage,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'countryCode': countryCode,
      'country': country,
      'isDeleted': isDeleted,
      'isBlocked': isBlocked,
      'role': role,
      'deletionDate': deletionDate,
      'status': status,
      'lastIpAddress': lastIpAddress,
      'deviceFingerprint': deviceFingerprint,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'accountStatus': accountStatus,
    };
  }
}