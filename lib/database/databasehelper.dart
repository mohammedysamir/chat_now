import 'package:chat_now/model/MyUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
CollectionReference<MyUser> getuserscollection(){
  return FirebaseFirestore.instance.collection(MyUser.COLLECTION_NAME).withConverter<MyUser>(
    fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );
}


