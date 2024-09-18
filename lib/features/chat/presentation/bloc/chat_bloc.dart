import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'chat_event.dart';
part 'chat_state.dart';

// BLoC
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ChatBloc() : super(ChatState([])) {
    on<SendMessageEvent>((event, emit) async {
      await _sendMessage(event.message);
      await _getBotResponse();
      emit(
        ChatState(
          await _getMessages(),
        ),
      );
    });
    on<ChatOnInitEvent>((event, emit) async {
      emit(
        ChatState(
          await _getMessages(),
        ),
      );
    });
  }

  Future<void> _sendMessage(String message) async {
    await _firestore.collection('messages').add({
      'text': message,
      'isUser': true,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _getBotResponse() async {
    // await Future.delayed(Duration(seconds: 1));

    String currentLang = Intl.getCurrentLocale().split('_')[0];

    QuerySnapshot botResponses = await _firestore
        .collection('bot_responses')
        .where('lang', isEqualTo: currentLang)
        .get();

    if (botResponses.docs.isNotEmpty) {
      String randomResponse =
          botResponses.docs[Random().nextInt(botResponses.docs.length)]['text'];
      await _firestore.collection('messages').add({
        'text': randomResponse,
        'isUser': false,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<List<Map<String, dynamic>>> _getMessages() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
