import 'dart:io';

import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/constants/gemini_constants.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

final userCreditsProvider = FutureProvider<double>((ref) async {
  final userData = await ref.read(currentUserDataProvider.future);
  return userData!.credits;
});

class DocScanning extends ConsumerStatefulWidget {
  const DocScanning({super.key});

  @override
  ConsumerState<DocScanning> createState() => _DocScanningState();
}

class _DocScanningState extends ConsumerState<DocScanning> {
  final model = GenerativeModel(
    model: 'gemini-2.0-flash',
    apiKey: geminiApi,
    generationConfig: GenerationConfig(
      temperature: 0.7,
      topP: 0.9,
    ),
  );

  XFile? pickedImage;
  String extractedText = '';
  bool scanning = false;
  final ImagePicker imagePicker = ImagePicker();
  TextEditingController languageController = TextEditingController();

  final List<String> languages = [
    "Hindi",
    "Marathi",
    "English",
    "Bengali",
    "Tamil",
    "Telugu",
    "Gujarati",
    "Kannada",
    "Malayalam",
    "Punjabi"
  ];

  @override
  void dispose() {
    languageController.dispose();
    super.dispose();
  }

  Future<void> deductCreditsForService() async {
    final currentUserId = await ref
        .read(currentUserAccountProvider.future)
        .then((user) => user?.$id);
    if (currentUserId != null) {
      await ref.read(authControllerProvider.notifier).deductCredits(
            uid: currentUserId,
            amount: 2.0,
            context: context,
          );
      setState(() {});
      ref.invalidate(userCreditsProvider); // Refresh credits after deduction
    }
  }

  Future<void> getImage(ImageSource source) async {
    XFile? result = await imagePicker.pickImage(source: source);
    if (result != null) {
      setState(() {
        pickedImage = result;
      });
      await performTextRecognition();
    }
  }

  Future<void> performTextRecognition() async {
    setState(() {
      scanning = true;
    });
    try {
      final inputImage = InputImage.fromFilePath(pickedImage!.path);
      final textRecognizer = TextRecognizer();
      final recognizedText = await textRecognizer.processImage(inputImage);

      setState(() {
        extractedText = recognizedText.text;
        scanning = false;
      });

      if (extractedText.isNotEmpty) {
        await generateSummary();
      }
    } catch (e) {
      setState(() {
        scanning = false;
      });
      print('Error during recognizing text: $e');
    }
  }

  Future<void> generateSummary() async {
    if (extractedText.trim().isEmpty) return;

    String selectedLanguage = languageController.text.isNotEmpty
        ? languageController.text
        : "English"; // Default to English

    List<Content> history = [
      Content.text(
          "You are NyaySahayak, an AI legal assistant specializing in Indian law and bhartiya nyay Sanhita"
          "Summarize the given legal document accurately."
          "Ensure the response is in $selectedLanguage."
          "Document text: $extractedText"),
    ];

    try {
      final responseAI = await model.generateContent(history);
      String aiSummary = responseAI.text?.replaceAll('*', '') ??
          'Could not generate a summary.';

      setState(() {
        extractedText = aiSummary;
      });

      await deductCreditsForService(); // Deduct credits only after summary is generated
    } catch (e) {
      print('Error during summary generation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doc Scanner'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return ref.watch(userCreditsProvider).when(
                    data: (credits) => Row(
                      children: [
                        Image.asset(
                          'assets/icons/ic_adhikar_coins.png',
                          height: 20,
                        ),
                        SizedBox(width: 5,),
                        Text('${credits.toStringAsFixed(2)}',style: TextStyle(color: Colors.white,fontSize: 19),),
                        SizedBox(width: 10,),
                      ],
                    ),
                    loading: () => Loader(),
                    error: (err, stack) => const Text('0'),
                  );
            },
          ),
        ],
        backgroundColor: Pallete.primaryColor,
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => getImage(ImageSource.gallery),
        child: SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: const Card(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 18),
            elevation: 20,
            color: Pallete.primaryColor,
            child: Center(
              child: Text(
                'Upload Document',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Pallete.primaryColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: DropDownField(
                    enabled: true,
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 16),
                    controller: languageController,
                    hintText: 'Select your language',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    items: languages,
                    itemsVisibleInDropdown: 4,
                    onValueChanged: (value) {
                      setState(() {
                        languageController.text = value;
                      });
                    },
                  ),
                ),
              ),
              scanning
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: Pallete.primaryColor),
                    )
                  : Expanded(
                      child: ListView(
                        children: [
                          const SizedBox(height: 20),
                          pickedImage != null
                              ? SizedBox(
                                  height: 300,
                                  width: 500,
                                  child: Image.file(File(pickedImage!.path)),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 20),
                          Text(
                            extractedText,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
