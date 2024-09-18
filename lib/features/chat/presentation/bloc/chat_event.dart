part of "chat_bloc.dart";

// Event
abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;
  SendMessageEvent(this.message);
}

class ChatOnInitEvent extends ChatEvent {}