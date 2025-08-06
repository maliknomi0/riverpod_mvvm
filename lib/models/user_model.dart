class UserModel {
  final int userId;
  final String skuId;
  final String name;
  final String username;
  final String email;
  final String phoneNo;
  final String? profilePic;
  final String? gender;
  final String? dateOfBirth;
  final String? address;
  final String countryCode;
  final String? country;
  final bool isDeleted;
  final bool isBlocked;
  final String role;
  final String subscriptionStatus;
  final String? subscriptionStartDate;
  final String? subscriptionEndDate;
  final String subscriptionType;
  final String? deletionDate;
  final int? planId;
  final int organizationId;
  final String lastIpAddress;
  final String deviceFingerprint;
  final String createdAt;
  final String updatedAt;
  final String organization;
  final String referralCodeUsed;
  final bool allowNotification;
  final bool? allowExerciseNotifications;
  final bool? allowLogsNotifications;
  final bool? allowNutritionNotifications;
  final String fcmToken;

  UserModel({
    required this.userId,
    required this.skuId,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNo,
    this.profilePic,
    this.gender,
    this.dateOfBirth,
    this.address,
    required this.countryCode,
    this.country,
    required this.isDeleted,
    required this.isBlocked,
    required this.role,
    required this.subscriptionStatus,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    required this.subscriptionType,
    this.deletionDate,
    this.planId,
    required this.organizationId,
    required this.lastIpAddress,
    required this.deviceFingerprint,
    required this.createdAt,
    required this.updatedAt,
    required this.organization,
    required this.referralCodeUsed,
    required this.allowNotification,
    this.allowExerciseNotifications,
    this.allowLogsNotifications,
    this.allowNutritionNotifications,
    required this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? 0,
      skuId: json['skuId'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      profilePic: json['profilePic'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      countryCode: json['countryCode'] ?? '',
      country: json['country'],
      isDeleted: json['isDeleted'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      role: json['role'] ?? '',
      subscriptionStatus: json['subscriptionStatus'] ?? '',
      subscriptionStartDate: json['subscriptionStartDate'],
      subscriptionEndDate: json['subscriptionEndDate'],
      subscriptionType: json['subscriptionType'] ?? '',
      deletionDate: json['deletionDate'],
      planId: json['planId'],
      organizationId: json['organizationId'] ?? 0,
      lastIpAddress: json['lastIpAddress'] ?? '',
      deviceFingerprint: json['deviceFingerprint'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      organization: json['organization'] ?? '',
      referralCodeUsed: json['referralCodeUsed'] ?? '',
      allowNotification: json['allowNotification'] ?? false,
      allowExerciseNotifications: json['allowExerciseNotifications'] ?? false,
      allowLogsNotifications: json['allowLogsNotifications'] ?? false,
      allowNutritionNotifications: json['allowNutritionNotifications'] ?? false,
      fcmToken: json['fcmToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'skuId': skuId,
        'name': name,
        'username': username,
        'email': email,
        'phoneNo': phoneNo,
        'profilePic': profilePic,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
        'address': address,
        'countryCode': countryCode,
        'country': country,
        'isDeleted': isDeleted,
        'isBlocked': isBlocked,
        'role': role,
        'subscriptionStatus': subscriptionStatus,
        'subscriptionStartDate': subscriptionStartDate,
        'subscriptionEndDate': subscriptionEndDate,
        'subscriptionType': subscriptionType,
        'deletionDate': deletionDate,
        'planId': planId,
        'organizationId': organizationId,
        'lastIpAddress': lastIpAddress,
        'deviceFingerprint': deviceFingerprint,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'organization': organization,
        'referralCodeUsed': referralCodeUsed,
        'allowNotification': allowNotification,
        'allowExerciseNotifications': allowExerciseNotifications,
        'allowLogsNotifications': allowLogsNotifications,
        'allowNutritionNotifications': allowNutritionNotifications,
        'fcmToken': fcmToken,
      };

  // copyWith bhi use karo future ke liye
  UserModel copyWith({
    int? userId,
    String? skuId,
    String? name,
    String? username,
    String? email,
    String? phoneNo,
    String? profilePic,
    String? gender,
    String? dateOfBirth,
    String? address,
    String? countryCode,
    String? country,
    bool? isDeleted,
    bool? isBlocked,
    String? role,
    String? subscriptionStatus,
    String? subscriptionStartDate,
    String? subscriptionEndDate,
    String? subscriptionType,
    String? deletionDate,
    int? planId,
    int? organizationId,
    String? lastIpAddress,
    String? deviceFingerprint,
    String? createdAt,
    String? updatedAt,
    String? organization,
    String? referralCodeUsed,
    bool? allowNotification,
    bool? allowExerciseNotifications,
    bool? allowLogsNotifications,
    bool? allowNutritionNotifications,
    String? fcmToken,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      skuId: skuId ?? this.skuId,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      profilePic: profilePic ?? this.profilePic,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      countryCode: countryCode ?? this.countryCode,
      country: country ?? this.country,
      isDeleted: isDeleted ?? this.isDeleted,
      isBlocked: isBlocked ?? this.isBlocked,
      role: role ?? this.role,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      subscriptionStartDate:
          subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      deletionDate: deletionDate ?? this.deletionDate,
      planId: planId ?? this.planId,
      organizationId: organizationId ?? this.organizationId,
      lastIpAddress: lastIpAddress ?? this.lastIpAddress,
      deviceFingerprint: deviceFingerprint ?? this.deviceFingerprint,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      organization: organization ?? this.organization,
      referralCodeUsed: referralCodeUsed ?? this.referralCodeUsed,
      allowNotification: allowNotification ?? this.allowNotification,
      allowExerciseNotifications:
          allowExerciseNotifications ?? this.allowExerciseNotifications,
      allowLogsNotifications:
          allowLogsNotifications ?? this.allowLogsNotifications,
      allowNutritionNotifications:
          allowNutritionNotifications ?? this.allowNutritionNotifications,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
