import 'package:adhikar_acehack4_o/constants/gemini_constants.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';

import 'widgets/chat_bubble.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final model = GenerativeModel(
    model: 'gemini-2.0-flash',
    apiKey: geminiApi,
    generationConfig: GenerationConfig(
      temperature: 0.7,
      topP: 0.9,
    ),
  );

  TextEditingController messageController = TextEditingController();
  bool isLoading = false;
  bool isMultilingual = false;
  double userCredits = 0.0;

  List<ChatBubble> chatBubbles = [
    const ChatBubble(
      direction: Direction.left,
      message:
          'Hello, I am Nyaysahayak. How can I assist you solve legal trouble?',
      photoUrl: 'https://i.pravatar.cc/150?img=47',
      type: BubbleType.alone,
    ),
  ];

  List<Content> history = [
    Content.text(
        "You are NyaySahayak, an AI legal assistant specializing in Indian law."
        "Your role is to provide clear, direct, and actionable legal solutions based strictly on the Indian Constitution and the Bharatiya Nyay Sanhita."
        "Always respond concisely with legal references and practical steps the user can take."
        "Your responses should be structured as follows:"
        "1. Relevant legal articles, sections, or precedents related to the user's issue."
        "2. Specific legal actions the user can take (filing complaints, contacting authorities, necessary documents, etc.)."
        "Avoid generic advice like 'stay calm' and focus on tangible legal remedies."
        "Respond in English"),
  ];

  @override
  void initState() {
    super.initState();
    fetchUserCredits();
  }

  Future<void> fetchUserCredits() async {
    final userData = await ref.read(currentUserDataProvider.future);
    setState(() {
      userCredits = userData!.credits;
    });
  }

  Future<void> deductCreditsForService() async {
    final currentUserId = await ref.read(currentUserAccountProvider.future).then((user) => user?.$id);
    if (currentUserId != null) {
      await ref.read(authControllerProvider.notifier).deductCredits(
            uid: currentUserId,
            amount: 2.0,
            context: context,
          );
      setState(() {
        userCredits -= 2.0; // Deduct locally
      });
    }
  }

  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;

    String userMessage = messageController.text.trim();

    // Add the user's message to the chat bubbles
    chatBubbles = [
      ...chatBubbles,
      ChatBubble(
        direction: Direction.right,
        message: userMessage,
        photoUrl: null,
        type: BubbleType.alone,
      )
    ];

    setState(() {
      isLoading = true;
    });

    // Deduct credits before processing AI response
    await deductCreditsForService();

    // Add user message to history
    history.add(Content.text("User: $userMessage"));

    try {
      // Generate AI response
      final responseAI = await model.generateContent(history);

      String aiResponse = responseAI.text?.replaceAll('*', '') ??
          'Sorry, I didn’t understand that.';

      
      history.add(Content.text("AI: $aiResponse"));

     
      chatBubbles = [
        ...chatBubbles,
        ChatBubble(
          direction: Direction.left,
          message: aiResponse,
          photoUrl: 'https://i.pravatar.cc/150?img=47',
          type: BubbleType.alone,
        )
      ];
    } catch (e) {
      print('Error during message processing: $e');
    } finally {
      messageController.clear();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nyaysahayak Chat'),
        actions: [
          Row(
            children: [
               Image.asset(
                          'assets/icons/ic_adhikar_coins.png',
                          height: 20,
                        ),
                        SizedBox(width: 5,),
              Text('${userCredits.toStringAsFixed(2)}',style: TextStyle(color: Colors.white,fontSize: 19),),
               SizedBox(width: 10,),
            ],
          )
        ],
        backgroundColor: Pallete.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                padding: const EdgeInsets.all(10),
                children: chatBubbles.reversed.toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: sendMessage,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
