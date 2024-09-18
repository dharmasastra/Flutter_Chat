import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/core/constants/constanst.dart';
import 'package:flutter_bloc_chat/core/localization/localization.dart';
import 'package:flutter_bloc_chat/features/chat/presentation/bloc/chat_bloc.dart';

class ButtonSend extends StatelessWidget {
  ButtonSend({
    super.key,
    required this.localizations,
  });

  final TextEditingController _controller = TextEditingController();
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > tabletScreen;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: localizations.typeAMessage,
                hintStyle: TextStyle(fontSize: isLargeScreen ? 20 : 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[100],
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.black),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  context
                      .read<ChatBloc>()
                      .add(SendMessageEvent(_controller.text));
                  _controller.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
