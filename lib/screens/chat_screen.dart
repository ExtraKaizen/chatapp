// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../widgets/chat_bubble.dart';
// import '../services/api_service.dart';
// import '../models/message.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final List<Message> _messages = [];
//   final TextEditingController _textController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   Future<void> _sendMessage() async {
//     if (_textController.text.isEmpty) return;

//     final userMessage = Message(
//       text: _textController.text,
//       isUser: true,
//       timestamp: DateTime.now(),
//     );

//     setState(() {
//       _messages.add(userMessage);
//       _textController.clear();
//     });

//     _scrollToBottom();

//     try {
//       final response = await ApiService.sendMessage(userMessage.text);

//       final aiMessage = Message(
//         text: response,
//         isUser: false,
//         timestamp: DateTime.now(),
//       );

//       setState(() {
//         _messages.add(aiMessage);
//       });
//       _scrollToBottom();
//     } catch (e) {
//       final errorMessage = Message(
//         text: 'Error: ${e.toString()}',
//         isUser: false,
//         timestamp: DateTime.now(),
//         isError: true,
//       );

//       setState(() {
//         _messages.add(errorMessage);
//       });
//       _scrollToBottom();
//     }
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   void _clearChat() {
//     setState(() {
//       _messages.clear();
//     });
//   }

//   Future<void> _exportChat() async {
//     // Implement export functionality
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat'),
//         backgroundColor: const Color(0xFF33333A),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.cleaning_services),
//             onPressed: _clearChat,
//           ),
//           IconButton(icon: const Icon(Icons.download), onPressed: _exportChat),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               padding: const EdgeInsets.all(8.0),
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return ChatBubble(
//                   message: _messages[index],
//                   onRegenerate: () {},
//                   onCopy: () {
//                     Clipboard.setData(
//                       ClipboardData(text: _messages[index].text),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Container(
//             color: const Color(0xFF33333A),
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       hintText: 'Ask me anything...',
//                       hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
//                       filled: true,
//                       fillColor: const Color(0xFF383842),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16.0,
//                         vertical: 12.0,
//                       ),
//                     ),
//                     onSubmitted: (_) => _sendMessage(),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   color: const Color(0xFF4A90E2),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/chat_bubble.dart';
import '../services/api_service.dart';
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> _sendMessage() async {
    if (_textController.text.isEmpty) return;

    final userMessage = Message(
      text: _textController.text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _textController.clear();
    });

    _scrollToBottom();

    try {
      final response = await ApiService.sendMessage(userMessage.text);

      final aiMessage = Message(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(aiMessage);
      });
      _scrollToBottom();
    } catch (e) {
      final errorMessage = Message(
        text: 'Error: ${e.toString()}',
        isUser: false,
        timestamp: DateTime.now(),
        isError: true,
      );

      setState(() {
        _messages.add(errorMessage);
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
    });
  }

  Future<void> _exportChat() async {
    if (_messages.isEmpty) return;

    final StringBuffer chatHistory = StringBuffer();
    for (final message in _messages) {
      chatHistory
          .writeln('[${message.timestamp}] ${message.isUser ? 'User' : 'AI'}:');
      chatHistory.writeln(message.text);
      chatHistory.writeln();
    }

    try {
      await Clipboard.setData(ClipboardData(text: chatHistory.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Chat history copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Export failed: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _regenerateResponse(int index) async {
    if (index <= 0 || _messages[index].isUser) return;

    final userMessage = _messages[index - 1];
    if (!userMessage.isUser) return;

    setState(() {
      _messages.removeAt(index);
    });

    try {
      final response = await ApiService.sendMessage(userMessage.text);

      final aiMessage = Message(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.insert(index, aiMessage);
      });
      _scrollToBottom();
    } catch (e) {
      final errorMessage = Message(
        text: 'Error: ${e.toString()}',
        isUser: false,
        timestamp: DateTime.now(),
        isError: true,
      );

      setState(() {
        _messages.insert(index, errorMessage);
      });
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: const Color(0xFF33333A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services),
            onPressed: _clearChat,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportChat,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  message: message,
                  onRegenerate:
                      message.isUser ? null : () => _regenerateResponse(index),
                  onCopy: () {
                    Clipboard.setData(ClipboardData(text: message.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Copied to clipboard'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: const Color(0xFF33333A),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Ask me anything...',
                      hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                      filled: true,
                      fillColor: const Color(0xFF383842),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: const Color(0xFF4A90E2),
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
