import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// =======================
/// Chat message model
/// =======================
class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}

/// =======================
/// SHE Smart Bot Screen
/// =======================
class SheBotChatScreen extends StatefulWidget {
  /// 🔑 Callback to trigger SOS from HomeScreen
  final VoidCallback onTriggerSOS;

  const SheBotChatScreen({
    super.key,
    required this.onTriggerSOS,
  });

  @override
  State<SheBotChatScreen> createState() => _SheBotChatScreenState();
}

class _SheBotChatScreenState extends State<SheBotChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  bool showSOSConfirm = false;
  bool isLoading = false;

  /// =======================
  /// Send message to backend
  /// =======================
  Future<void> sendMessage(String message) async {
    setState(() {
      _messages.add(ChatMessage(text: message, isUser: true));
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/she-bot/chat"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": message}),
      );

      final data = jsonDecode(response.body);

      setState(() {
        _messages.add(ChatMessage(
          text: data["reply"] ?? "I’m here with you.",
          isUser: false,
        ));
        showSOSConfirm = data["suggest_sos"] == true;
        isLoading = false;
      });
    } catch (_) {
      setState(() {
        _messages.add(ChatMessage(
          text: "Sorry, I’m having trouble connecting right now.",
          isUser: false,
        ));
        isLoading = false;
      });
    }
  }

  /// =======================
  /// UI
  /// =======================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHE Smart Bot"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          /// Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];

                return Align(
                  alignment:
                      msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg.isUser
                          ? Colors.pinkAccent
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.isUser ? Colors.white : Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Typing indicator
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text("SHE Bot is typing..."),
            ),

          /// 🔴 SOS Confirmation Bar
          if (showSOSConfirm) sosConfirmUI(),

          /// Input box
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.pinkAccent),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      sendMessage(_controller.text.trim());
                      _controller.clear();
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// =======================
  /// SOS Confirmation UI
  /// =======================
  Widget sosConfirmUI() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.red.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              "Do you want to trigger SOS?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() => showSOSConfirm = false);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: triggerSOS,
                child: const Text("YES, SOS"),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// =======================
  /// Trigger SOS (SAFE)
  /// =======================
  void triggerSOS() {
    setState(() {
      showSOSConfirm = false;
      _messages.add(ChatMessage(
        text: "🚨 SOS triggered. Alerting your trusted contacts.",
        isUser: false,
      ));
    });

    /// 🔥 Calls HomeScreen.sendSOS()
    widget.onTriggerSOS();
  }
}
