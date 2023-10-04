import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gpt_voice_assistant_app/feature_box.dart';
import 'package:gpt_voice_assistant_app/menu_drawer.dart';
import 'package:gpt_voice_assistant_app/openai_service.dart';
import 'package:gpt_voice_assistant_app/pallete.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:animate_do/animate_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FlutterTts flutterTts = FlutterTts();
  final speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  final int start = 500;
  final int delay = 500;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeec();
  }

  Future<void> initTextToSpeec() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;

      print("Recognized Speech: $lastWords");

      // if (result.finalResult) {
      //   openAIService.isArtPromptAPI(lastWords);
      // }
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    // this function is called when the widget is removed from the widget tree
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Voice GPT',
            style: TextStyle(
              color: Pallete.mainFontColor,
              fontFamily: 'Cera Pro',
            ),
          ),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Pallete.menuColor,
            ),
          ),
        ),
        drawer: const SafeArea(child: MenuDrawer()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Virtual Assistant Picture
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Pallete.assistantCircleColor,
                    ),
                    ElasticIn(
                      delay: Duration(milliseconds: start + delay),
                      child: Image.asset(
                        'assets/images/virtualAssistant2.png',
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ],
                ),
              ),
              // Chat Cloud Bubble
              FadeInLeft(
                delay: Duration(milliseconds: start + delay * 2),
                child: Visibility(
                  visible: generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ).copyWith(
                      top: 30,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Pallete.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(20).copyWith(
                        topLeft: Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        generatedContent == null ? 'Welcome, what task can I do for you?' : generatedContent!,
                        style: TextStyle(
                          color: Pallete.mainFontColor,
                          fontFamily: 'Cera Pro',
                          // fontsize should automatically adjust based on the length of the text
                          fontSize: generatedContent == null ? 24 : 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              if (generatedImageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(generatedImageUrl!)),
                ),

              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 22,
                  ),
                  child: const Text(
                    'Here are a few commands',
                    style: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              // Features List
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Column(
                  children: [
                    FadeInLeft(
                      delay: Duration(milliseconds: start + delay * 3),
                      child: const FeatureBox(
                        color: Pallete.firstSuggestionBoxColor,
                        headerText: 'ChatGPT',
                        descriptionText: 'A smarter way to stay organized and informed with ChatGPT',
                      ),
                    ),
                    FadeInLeft(
                      delay: Duration(milliseconds: start + delay * 4),
                      child: const FeatureBox(
                        color: Pallete.secondSuggestionBoxColor,
                        headerText: 'Dall-E',
                        descriptionText: 'Get inspired and stay creative with your personal assistant powered by Dall-E',
                      ),
                    ),
                    FadeInLeft(
                      delay: Duration(milliseconds: start + delay * 5),
                      child: const FeatureBox(
                        color: Pallete.thirdSuggestionBoxColor,
                        headerText: 'Smart Voice Assistant',
                        descriptionText: 'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Bounce(
          delay: Duration(milliseconds: start + delay * 6),
          child: FloatingActionButton(
            onPressed: () async {
              if (await speechToText.hasPermission && speechToText.isNotListening) {
                await startListening();
              } else if (speechToText.isListening) {
                final speech = await openAIService.isArtPromptAPI(lastWords);
                //print("Speech: $speech");
                //await systemSpeak(speech);
                //await openAIService.isArtPromptAPI(lastWords);
                //String response = await openAIService.isArtPromptAPI(lastWords);
                //print("Response from isArtPromptAPI: $response");
                if (speech.contains('https')) {
                  generatedImageUrl = speech;
                  generatedContent = lastWords;
                } else {
                  generatedImageUrl = null;
                  generatedContent = speech;
                  setState(() {});
                  await systemSpeak(speech);
                }
                await stopListening();
              } else {
                initSpeechToText();
              }
            },
            backgroundColor: Pallete.lightBackgroundColor,
            child: Icon(
              speechToText.isListening ? Icons.stop : Icons.mic,
              //Icons.mic,
              color: Pallete.blackColor,
            ),
          ),
        ));
  }
}
