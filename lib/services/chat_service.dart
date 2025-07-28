import 'package:android_chat_app/component/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //get instance of firestore and auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  /*
  [
    {
      'email' : test@gmail.com,
      'id' : ....
    },
    {
      'email' : john@gmail.com,
      'id' : ....
    },
  ]
  */
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go through each individual user
        final user = doc.data();

        //return user
        return user;
      }).toList();
    });
  }

  //send messages
  Future<void> sendMessage(String message) async {
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      message: message,
      timestamp: timestamp,
    );

    //construct group chat room
    String chatRoomID =
        "group_chat"; //for simplicity, using a static chat room ID

    //add new message to database
    await _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get messages
  Stream<List<Message>> getMessagesStream() {
    String chatRoomID = "group_chat"; // Static chat room ID
    return _firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return Message(
              senderID: data['senderID'] ?? '',
              senderEmail: data['senderEmail'] ?? '',
              message: data['message'] ?? '',
              timestamp: data['timestamp'] ?? Timestamp.now(),
            );
          }).toList();
        });
  }
}
