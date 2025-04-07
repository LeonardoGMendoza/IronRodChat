import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/organization.dart';

class ChatPage extends StatefulWidget {
  final Organization organization;

  const ChatPage({Key? key, required this.organization}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AudioPlayer _player = AudioPlayer();

  User? get user => _auth.currentUser;

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || user == null) return;

    await _firestore.collection('messages').add({
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'uid': user!.uid,
      'email': user!.email,
      'photoURL': user!.photoURL, // 👈 salva foto do perfil do Firebase
      'organization': widget.organization.name,
    });

    _controller.clear();
    await _player.play(AssetSource('sounds/send.mp3'));
  }

  Color getColorFromUID(String uid) {
    final hash = uid.codeUnits.fold(0, (sum, code) => sum + code);
    final colors = [
      Colors.blue, Colors.red, Colors.green, Colors.orange,
      Colors.purple, Colors.teal, Colors.brown, Colors.indigo,
    ];
    return colors[hash % colors.length];
  }

  Widget _buildInitialCircle(String initial, Color bgColor) {
    return Container(
      color: bgColor,
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat - ${widget.organization.displayName}'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .where('organization', isEqualTo: widget.organization.name)
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final isMe = data['uid'] == currentUser?.uid;
                    final userColor = getColorFromUID(data['uid'] ?? '');
                    final senderInitial = (data['email'] ?? 'U')[0].toUpperCase();

                    if (!isMe && index == docs.length - 1) {
                      _player.play(AssetSource('sounds/receive.mp3'));
                    }

                    final messageBubble = Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.green[100] : Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: Radius.circular(isMe ? 12 : 0),
                          bottomRight: Radius.circular(isMe ? 0 : 12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isMe)
                            Text(
                              data['email'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            data['text'] ?? '',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isMe)
                            Container(
                              margin: const EdgeInsets.only(right: 8, top: 4),
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: data['photoURL'] != null &&
                                    data['photoURL'].toString().isNotEmpty
                                    ? Image.network(
                                  data['photoURL'],
                                  fit: BoxFit.cover,
                                  width: 36,
                                  height: 36,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildInitialCircle(senderInitial, userColor);
                                  },
                                )
                                    : _buildInitialCircle(senderInitial, userColor),
                              ),
                            ),
                          messageBubble,
                          if (isMe) const SizedBox(width: 40),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite uma mensagem...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.deepPurple),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
