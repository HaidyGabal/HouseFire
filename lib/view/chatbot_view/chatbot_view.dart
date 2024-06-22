// import 'package:dialog_flowtter/dialog_flowtter.dart';
// import 'package:flutter/material.dart';
// import 'package:newesp/view/chatbot_view/widgets/MessagesScreenChatBot.dart';
//
// import '../../Home.dart';
// import '../../MyDrawerScreen.dart';
// import '../../NavBar.dart';
//
//
// class ChatBotView extends StatefulWidget {
//   const ChatBotView({super.key});
//
//   @override
//   State<ChatBotView> createState() => _ChatBotViewState();
// }
//
// class _ChatBotViewState extends State<ChatBotView> {
//   late DialogFlowtter dialogFlowtter;
//   final TextEditingController _controller = TextEditingController();
//
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Services Chatbot'),
//         leading: BackButton(
//           onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder:(context)=> Home()));
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(child: MessagesScreenChatBot(messages: messages)),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//               color: Colors.grey,
//               child: Row(
//                 children: [
//                   Expanded(
//                       child: TextField(
//                     controller: _controller,
//                     style: TextStyle(color:Colors.grey.shade400,),
//                   )),
//                   IconButton(
//                       onPressed: () {
//                         sendMessage(_controller.text);
//                         _controller.clear();
//                       },
//                       icon: Icon(
//                         color: Colors.orange,
//                           Icons.send))
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//
//
//
//
//     );
//   }
//
//   sendMessage(String text) async {
//     if (text.isEmpty) {
//       print('Message is empty');
//     } else {
//       setState(() {
//         addMessage(Message(text: DialogText(text: [text])), true);
//       });
//
//       DetectIntentResponse response = await dialogFlowtter.detectIntent(queryInput: QueryInput(text: TextInput(text: text)));
//       if (response.message == null) return;
//       setState(() {
//         addMessage(response.message!);
//       });
//     }
//   }
//
//   addMessage(Message message, [bool isUserMessage = false]) {
//     messages.add({'message': message, 'isUserMessage': isUserMessage});
//   }
// }
