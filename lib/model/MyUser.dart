// parsing from json to object class for the user collection
class MyUser {
  static const String COLLECTION_NAME = 'users';
  String ID;
  String username;
  String email;

  MyUser({required this.ID, required this.username, required this.email});

  // named parameter that must be sent.
  MyUser.fromJson(Map<String, Object?> json)
      : this(
    ID: json['ID']! as String,
    username: json['username']! as String,
    email: json['email'] ! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'ID': ID,
      'username': username,
      'email': email,
    };
  }
}