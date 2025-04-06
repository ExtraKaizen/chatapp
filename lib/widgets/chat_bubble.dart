// import 'package:flutter/material.dart';
// // Removed unnecessary import: import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import '../models/message.dart';

// class ChatBubble extends StatelessWidget {
//   final Message message;
//   final VoidCallback onRegenerate;
//   final VoidCallback onCopy;

//   const ChatBubble({
//     super.key,
//     required this.message,
//     required this.onRegenerate,
//     required this.onCopy,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           alignment:
//               message.isUser ? Alignment.centerRight : Alignment.centerLeft,
//           margin: const EdgeInsets.symmetric(vertical: 4),
//           child: Container(
//             constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.8),
//             decoration: BoxDecoration(
//               color:
//                   message.isUser
//                       ? const Color(0xFF2a52be)
//                       : const Color(0xFF4F4F4F),
//               borderRadius: BorderRadius.only(
//                 topLeft: const Radius.circular(15),
//                 topRight: const Radius.circular(15),
//                 bottomLeft:
//                     message.isUser
//                         ? const Radius.circular(15)
//                         : const Radius.circular(2),
//                 bottomRight:
//                     message.isUser
//                         ? const Radius.circular(2)
//                         : const Radius.circular(15),
//               ),
//             ),
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   message.text,
//                   style: const TextStyle( // Added const
//                     color: Color(0xFFE0E0E0),
//                     fontSize: 16,
//                     height: 1.4,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       DateFormat('h:mm a').format(message.timestamp),
//                       style: const TextStyle( // Added const
//                         color: Color(0xFFAAAAAA),
//                         fontSize: 10,
//                       ),
//                     ),
//                     if (!message.isUser)
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.refresh, size: 20), // Added const
//                             color: const Color(0xFFAAAAAA),
//                             onPressed: onRegenerate,
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.copy, size: 20), // Added const
//                             color: const Color(0xFFAAAAAA),
//                             onPressed: onCopy,
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final VoidCallback? onRegenerate;
  final VoidCallback onCopy;

  const ChatBubble({
    super.key,
    required this.message,
    this.onRegenerate,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          alignment:
              message.isUser ? Alignment.centerRight : Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth * 0.8,
            ),
            decoration: BoxDecoration(
              color: message.isUser
                  ? const Color(0xFF2a52be)
                  : const Color(0xFF4F4F4F),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: message.isUser
                    ? const Radius.circular(15)
                    : const Radius.circular(2),
                bottomRight: message.isUser
                    ? const Radius.circular(2)
                    : const Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.text,
                  style: const TextStyle(
                    color: Color(0xFFE0E0E0),
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('h:mm a').format(message.timestamp),
                      style: const TextStyle(
                        color: Color(0xFFAAAAAA),
                        fontSize: 10,
                      ),
                    ),
                    if (!message.isUser)
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.refresh, size: 20),
                            color: const Color(0xFFAAAAAA),
                            onPressed: onRegenerate,
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy, size: 20),
                            color: const Color(0xFFAAAAAA),
                            onPressed: onCopy,
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
