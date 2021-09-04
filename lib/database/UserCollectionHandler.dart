import 'package:chat_now/model/MyUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCollectionHandler {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final usersRef = FirebaseFirestore.instance
      .collection(MyUser.COLLECTION_NAME)
      .withConverter<MyUser>(
        fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  // user CRUD operations:

  // EFFECTS: returns a list of users from the database, returns an empty list in case of an error
  Future<List<MyUser>> getUsers() async {
    try {
      QuerySnapshot users = await usersRef.get();
      return users.docs.map((doc) {
        MyUser user = doc.data()! as MyUser;
        return user;
      }).toList();
    } catch (e) {
      print(e);
      return List.empty();
    }
  }

  // EFFECTS: return a user given his id
  Future<MyUser?> getUser(String id) async {
    try {
      DocumentSnapshot user = await usersRef.doc(id).get();
      return user.data()! as MyUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // EFFECTS: returns a stream of users that updates in real time to be used in a stream builder
  Stream getUsersStream() {
    return usersRef.snapshots();
  }

  // EFFECTS: registers a new user in the database
  Future<void> registerUser(
      String email, String username, String password) async {

    final FirebaseAuth auth = FirebaseAuth.instance;
    try {

      final conflictingUsers = await usersRef.where('username', isEqualTo: username).get();
      if (conflictingUsers.docs.isNotEmpty) throw Exception('username already in use');

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await usersRef.doc(userCredential.user!.uid).set(MyUser(
        ID: userCredential.user!.uid,
        username: username,
        email: email,
      ));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // EFFECTS: returns current signed in user
  User? getCurrentUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      print("not signed in");
    }
    return auth.currentUser;
  }

  // EFFECTS: updates user data of the current signed in user, fields are optional
  Future<void> updateCurrentUser (String? email, String? username, String? password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      if (email != null){
        await usersRef.doc(auth.currentUser!.uid).update({'email': email});
        await auth.currentUser!.updateEmail(email);
      }

      if (username != null){
        await usersRef.doc(auth.currentUser!.uid).update({'username': username});
      }

      if (password != null){
        await usersRef.doc(auth.currentUser!.uid).update({'password': password});
        await auth.currentUser!.updatePassword(password);
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('The user must reauthenticate before this operation can be executed.');
      }
    }
    catch(e){
      print(e);
    }

  }

  // EFFECTS: deletes current signed in user
  Future<void> deleteCurrentUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await usersRef.doc(auth.currentUser!.uid).delete();
      await auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('The user must reauthenticate before this operation can be executed.');
      }
    }
    catch(e){
      print(e);
    }
  }

  // EFFECTS: signs in the user given correct email & password
  Future<void> signIn(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // EFFECTS: signs out the user
  Future<void> signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }

}
