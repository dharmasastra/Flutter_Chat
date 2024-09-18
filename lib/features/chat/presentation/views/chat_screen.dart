import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/core/constants/constanst.dart';
import 'package:flutter_bloc_chat/core/localization/localization.dart';
import 'package:flutter_bloc_chat/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_bloc_chat/features/chat/widgets/button_send.dart';
import 'package:flutter_bloc_chat/features/chat/widgets/chat_buble.dart';
import 'package:flutter_bloc_chat/features/chat/widgets/switch_language_button.dart';

class ChatScreen extends StatefulWidget {
  final Function(Locale) setLocale;

  const ChatScreen({super.key, required this.setLocale});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    context.read<ChatBloc>().add(ChatOnInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > tabletScreen;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.chatWithBot,
          style: TextStyle(
            fontSize: isLargeScreen ? 25 : 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          SwitchLanguageButton(
            setLocale: widget.setLocale,
            localizations: localizations,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isLargeScreen ? 700 : double.infinity,
                ),
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return ChatBuble(
                          message: message['text'],
                          isUser: message['isUser'],
                          localizations: localizations,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          ButtonSend(localizations: localizations),
        ],
      ),
    );
  }
}
