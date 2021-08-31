import 'package:chat_now/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
CollectionReference<User> getuserscollection(){
  return FirebaseFirestore.instance.collection(User.COLLECTION_NAME).withConverter<User>(
    fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
    toFirestore: (User, _) => User.toJson(),
  );
}


