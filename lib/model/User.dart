// parsing from json to object class for the user collection
class User {
  static const String COLLECTION_NAME = 'users';
  String ID;
  String Username;
  String email;

  User({required this.ID, required this.Username, required this.email});

  // named parameter that must be sent.
  User.fromJson(Map<String, Object?> json)
      : this(
    ID: json['ID']! as String,
    Username: json['Username']! as String,
    email: json['email'] ! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'ID': ID,
      'Username': Username,
      'email': email,
    };
  }
}