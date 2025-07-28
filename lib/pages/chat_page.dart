import 'package:android_chat_app/component/message.dart';
import 'package:android_chat_app/services/auth_servic.dart';
import 'package:android_chat_app/services/chat_service.dart';
import 'package:flutter/material.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({super.key});

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  final TextEditingController _messagecontroller = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Add a ScrollController
  final ScrollController _scrollController = ScrollController();

  // A flag to ensure we only scroll to the bottom once on initial load
  bool _initialScrollDone = false;

  @override
  void initState() {
    super.initState();
    // This listener will handle subsequent new messages arriving
    _chatService.getMessagesStream().listen((_) {
      // Add a slight delay to ensure list has rebuilt before trying to scroll
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Only scroll to bottom if the user is already near the bottom
        // or if it's the very first load and we need to jump to the latest message.
        if (_scrollController.hasClients &&
            (_scrollController.position.pixels >=
                    _scrollController.position.maxScrollExtent * 0.9 || // Check if within 90% of bottom
                !_initialScrollDone)) { // Or if it's the initial load
          _scrollToBottom();
          _initialScrollDone = true; // Ensure this is set after first scroll
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messagecontroller.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    //if there is something inside the text field
    if (_messagecontroller.text.isNotEmpty) {
      //send the message
      await _chatService.sendMessage(_messagecontroller.text);
      //clear the text field
      _messagecontroller.clear();
      _scrollToBottom(); // Scroll to bottom after sending a message
    }
  }

  void _scrollToBottom() {
    // Check if the controller is attached and we can scroll
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text("Rom Dynamic"), // Added an AppBar for better UI
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _authService.signOut();
              // Navigate back to authentication gate
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          //display all message
          Expanded(
            child: _buildMessageList(),
          ),

          //input field
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<List<Message>>(
      stream: _chatService.getMessagesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No messages yet"));
        }

        // Add the controller to the ListView.builder
        return ListView.builder(
          controller: _scrollController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final message = snapshot.data![index];
            bool isCurrentUser = message.senderID == _authService.getCurrentUser()!.uid;

            return Align(
              alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isCurrentUser ? Colors.blue[400] : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isCurrentUser ? 12 : 0),
                    topRight: Radius.circular(isCurrentUser ? 0 : 12),
                    bottomLeft: const Radius.circular(12),
                    bottomRight: const Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.senderEmail,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      message.message,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      message.timestamp.toDate().toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  //build input field
  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messagecontroller,
              decoration: const InputDecoration(
                hintText: "Type a message",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

   /*Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        //return list view
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context))
          .toList(),
        );
      },
      );
  }

  //build individal list tile for user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    //display all user except current user
    return UserTile(
      text: userData["email"],
    );
  }*/
}