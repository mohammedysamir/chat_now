// parsing from json to object class for the chat room collection
class Room {
  static const String COLLECTION_NAME = 'rooms';
  String? ID;
  String name;
  String category;
  String description;
  String createdBy;

  Room({
    this.ID,
    required this.name,
    required this.category,
    required this.createdBy,
    this.description = ""
  });

  // named parameter that must be sent.
  Room.fromJson(Map<String, Object?> json)
      : this(
    ID: json['ID']! as String,
    name: json['name']! as String,
    category: json['category']! as String,
    description: json['description'] ! as String,
    createdBy: json['createdBy']! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'ID': ID,
      'name': name,
      'category': category,
      'description': description,
      'createdBy': createdBy,
    };
  }
}