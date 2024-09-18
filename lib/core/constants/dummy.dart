import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addLocalizedDummyData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  Map<String, List<String>> localizedResponses = {
    'en': [
      "Hello! How can I assist you today?",
      "That's an interesting question. Let me think about it.",
      "I'm sorry, I don't have information on that topic.",
      "Could you please provide more details?",
      "That's great! Is there anything else you'd like to know?",
    ],
    'ja': [
      "こんにちは！今日はどのようにお手伝いできますか？",
      "それは面白い質問ですね。少し考えてみましょう。",
      "申し訳ありませんが、その話題に関する情報がありません。",
      "もう少し詳しく教えていただけますか？",
      "素晴らしいです！他に知りたいことはありますか？",
    ],
  };

  WriteBatch batch = firestore.batch();

  localizedResponses.forEach((lang, responses) {
    for (String response in responses) {
      DocumentReference docRef = firestore.collection('bot_responses').doc();
      batch.set(docRef, {'text': response, 'lang': lang});
    }
  });

  await batch.commit();
  print('Localized dummy data added successfully!');
}