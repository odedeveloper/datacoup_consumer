import 'dart:convert';

final RegExp _mobileNumberRegExp = RegExp(r'^[0-9]*$');
final RegExp _emailRegExp = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);
final RegExp _passwordRegExp = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
);

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toMap());

class UserModel {
  String? odenId = '';
  String? firstName = '';
  String? lastName = '';
  String? otp = '';
  String? confirmPassword = '';
  String? referral = '';
  String? country = '+91';
  String? state = '';
  String? zipCode = '';
  String? code = '';
  String? phone = '';
  String? email = '';
  String? password = '';
  String? profileImage = '';
  String? gender = '';
  bool? isPayloadVerified = false;
  String? errorMessage = '';
  int? errorCode = 0;
  bool? formProcessing = false;
  String? dob = '';
  String? bestScore = '';
  String? emailVerified = 'False';
  String? phoneVerified = 'False';
  String? primary = '';
  bool? profileImageChange;
  // String badge = 'Digital Novice';

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.odenId,
    required this.country,
    required this.profileImage,
    // required this.fcmTokens,
    required this.gender,
    required this.dob,
    required this.state,
    required this.zipCode,
    required this.bestScore,
    required this.emailVerified,
    required this.phoneVerified,
    required this.primary,
    this.profileImageChange = false,
    // required this.badge,
  });

  factory UserModel.empty() => UserModel(
        odenId: null,
        firstName: null,
        lastName: null,
        phone: null,
        email: null,
        profileImage: null,
        gender: null,
        dob: null,
        country: null,
        state: null,
        zipCode: null,
        primary: null,
        bestScore: null,
        emailVerified: null,
        phoneVerified: null,
      );

  factory UserModel.fromJson(Map<String, dynamic> user) => UserModel(
        firstName: user['firstName'],
        lastName: user['lastName'],

        email: user.containsKey('email') ? user['email'] : '',
        phone: user.containsKey('phone') ? user['phone'] : '',
        odenId: user['odenId'],
        profileImage: user['profileImage'],
        primary: user['primary'],
        emailVerified: user.containsKey('emailVerified')
            ? user['emailVerified'].toString()
            : '',

        phoneVerified: user.containsKey('phoneVerified')
            ? user['phoneVerified'].toString()
            : '',
        // fcmTokens: user['fcmTokens'],
        gender: user['gender'],
        country: user['country'],
        state: user.containsKey('state') ? user['state'] : '',
        zipCode: user.containsKey('zipCode') ? user['zipCode'] : '',
        dob: user.containsKey('dob') ? user['dob'] : DateTime.now().toString(),
        bestScore: user.containsKey('bestScore') ? user['bestScore'] : '',
        // badge: user.containsKey('badge') ? user['badge'] : 'Digital Novice',
      );

  Map<String, dynamic> toMap() {
    return {
      'odenId': odenId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'country': country,
      'state': state,
      'zipCode': zipCode,
      'profileImage': profileImage,
      'gender': gender,
      'dob': dob,
      'bestScore': bestScore,
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      'primary': primary
      // 'badge': badge
    };
  }
}

class MethodResponse {
  bool isSuccess;
  String errorMessage;
  MethodResponse({this.isSuccess = false, this.errorMessage = ""});
}
