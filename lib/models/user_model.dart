class UserModel {
  UserModel({required this.userID});

  String userID;

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      userID: data['userID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
    };
  }
}