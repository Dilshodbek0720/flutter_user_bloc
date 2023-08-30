class UserModelFields {
  static const String id = "_id";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String age = "age";
  static const String gender = "gender";
  static const String jobTitle = "jobTitle";
  static const String table_name = "users";
}

class UserModel {
  int? id;
  final String firstName;
  final String lastName;
  final String age;
  final String gender;
  final String jobTitle;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.jobTitle,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? age,
    String? gender,
    String? jobTitle,
    int? id,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      jobTitle: jobTitle ?? this.jobTitle,
      id: id ?? this.id,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json[UserModelFields.firstName] ?? "",
      lastName: json[UserModelFields.lastName] ?? "",
      age: json[UserModelFields.age] ?? "",
      gender: json[UserModelFields.gender] ?? "",
      jobTitle: json[UserModelFields.jobTitle] ?? "",
      id: json[UserModelFields.id] ?? 0,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      UserModelFields.firstName: firstName,
      UserModelFields.lastName: lastName,
      UserModelFields.age: age,
      UserModelFields.gender: gender,
      UserModelFields.jobTitle: jobTitle
    };
  }

  @override
  String toString() {
    return '''
      firstName: $firstName
      lastName: $lastName
      age: $age
      gender: $gender
      jobTitle: $jobTitle
      id: $id, 
    ''';
  }
}
