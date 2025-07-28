import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.message,
    required this.timestamp,
  });

  factory Message.fromDocument(Map<String, dynamic> data) {
    return Message(
      senderID: data['senderID'] ?? '',
      senderEmail: data['senderEmail'] ?? '',
      message: data['message'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
