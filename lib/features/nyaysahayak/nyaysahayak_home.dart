import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/features/nyaysahayak/chat_screen.dart';
import 'package:adhikar_acehack4_o/features/nyaysahayak/doc_scanning.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NyaysahayakHomePage extends ConsumerStatefulWidget {
  const NyaysahayakHomePage({super.key});

  @override
  ConsumerState<NyaysahayakHomePage> createState() =>
      _NyaysahayakHomePageState();
}

class _NyaysahayakHomePageState extends ConsumerState<NyaysahayakHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Pallete.primaryColor,
            statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'NyaySahayak',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          ref.watch(userCreditsProvider).when(
              data: (credits) {
                return Row(
                  children: [
                    Image.asset(
                  'assets/icons/ic_adhikar_coins.png',
                  height: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                    Text(credits.toString(),style: TextStyle(color: Colors.white,fontSize: 19),),
                    const SizedBox(
                  width: 10,
                ),
                  ],
                );
              },
              error: (err, st) => ErrorPage(error: err.toString()),
              loading: () => Loader())
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const DocScanning();
                }));
              },
              child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 20,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DottedBorder(
                              color: Colors.red,
                              strokeCap: StrokeCap.round,
                              strokeWidth: 1.3,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(100),
                              dashPattern: const [3, 5],
                              child: const SizedBox(
                                height: 40,
                                width: 40,
                                child: const Center(
                                    child: Text(
                                  '01',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                              )),
                        ),
                        const Expanded(
                          child: const Text(
                            'Document Scanning',
                            style: TextStyle(
                                color: Pallete.primaryColor, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Image.asset(
                            'assets/icons/ic_forward.png',
                            height: 15,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ChatPage();
                }));
              },
              child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 20,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DottedBorder(
                              color: Colors.blue,
                              strokeCap: StrokeCap.round,
                              strokeWidth: 1.3,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(100),
                              dashPattern: const [3, 5],
                              child: const SizedBox(
                                height: 40,
                                width: 40,
                                child: const Center(
                                    child: Text(
                                  '02',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                              )),
                        ),
                        const Expanded(
                          child: const Text(
                            'ChatBot',
                            style: TextStyle(
                                color: Pallete.primaryColor, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Image.asset(
                            'assets/icons/ic_forward.png',
                            height: 15,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
