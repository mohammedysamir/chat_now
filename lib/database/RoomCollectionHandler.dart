import 'package:chat_now/model/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomCollectionHandler {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final roomsRef = FirebaseFirestore.instance
      .collection(Room.COLLECTION_NAME)
      .withConverter<Room>(
        fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
        toFirestore: (room, _) => room.toJson(),
      );

  // user crud operations
  // EFFECTS: returns a list of rooms from the database, returns an empty list in case of an error
  Future<List<Room>> getRooms() async {
    try {
      QuerySnapshot rooms = await roomsRef.get();
      return rooms.docs.map((doc) {
        Room room = doc.data()! as Room;
        return room;
      }).toList();
    } catch (e) {
      print(e);
      return List.empty();
    }
  }

  // EFFECTS: returns a stream of rooms that updates in real time to be used in a stream builder
  Stream<QuerySnapshot> getRoomsStream() {
    return roomsRef.snapshots();
  }

  // EFFECTS: return rooms that match a search query
  Future<List<Room>> getRoom(String searchQuery) async {
    try {
      QuerySnapshot rooms = await roomsRef.orderBy('name')
          .startAt([searchQuery])
          .endAt([searchQuery + '\uf8ff'])
          .get();
      return rooms.docs.map((doc) {
        Room room = doc.data()! as Room;
        return room;
      }).toList();
    } catch (e) {
      print(e);
      return List.empty();
    }
  }

  // EFFECTS: creates a new room in the database
  Future<void> addRoom(Room room) async {
    try {
      final conflictingRooms =
          await roomsRef.where('name', isEqualTo: room.name).get();
      if (conflictingRooms.docs.isNotEmpty)
        throw Exception('room name already in use');

      final roomID = roomsRef.doc().id;
      await roomsRef.doc(roomID).set(Room(
          ID: roomID,
          name: room.name,
          category: room.category,
          description: room.description,
          createdBy: room.createdBy));
    } catch (e) {
      print(e);
    }
  }

  // EFFECTS: deletes current signed in user
  Future<void> deleteRoom(String roomID) async {
    try {
      await roomsRef.doc(roomID).delete();
    } catch (e) {
      print(e);
    }
  }
}
