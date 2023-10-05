import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final List<Map<String, String>> messages = [];

  // Function to check if the prompt is asking for an AI generated image
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      await dotenv.load(fileName: ".env");
      final openAIAPIKey = dotenv.env['OPENAI_API_KEY'];
      final response = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAIAPIKey'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                'role': 'user',
                'content': 'Does this message want to generate an image, picture, art, drawing, painting, sketch, illustration, graphics, photo or anything similar? $prompt. Simply answer with a yes or no.',
              }
            ]
          }));

      if (response.statusCode == 200) {
        String content = jsonDecode(response.body)['choices'][0]['message']['content'];
        content = content.trim();
        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final response = await dallEAPI(prompt);

            return response;
          default:
            final response = await chatGPTAPI(prompt);

            return response;
        }
      }
      return 'An internal error occurred.';
    } catch (e) {
      return e.toString();
    }
  }

  // Function to chat with GPT-3
  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      await dotenv.load(fileName: ".env");
      final openAIAPIKey = dotenv.env['OPENAI_API_KEY'];
      final response = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAIAPIKey'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": messages,
          }));

      if (response.statusCode == 200) {
        String content = jsonDecode(response.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });

        return content;
      }
      return 'An internal error occurred.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      await dotenv.load(fileName: ".env");
      final openAIAPIKey = dotenv.env['OPENAI_API_KEY'];
      final response = await http.post(Uri.parse('https://api.openai.com/v1/images/generations'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAIAPIKey'
          },
          body: jsonEncode({
            'prompt': prompt,
            'n': 1,
            'size': '256x256'
          }));

      if (response.statusCode == 200) {
        String imageUrl = jsonDecode(response.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();

        messages.add({
          'role': 'assistant',
          'content': imageUrl,
        });

        return imageUrl;
      }
      return 'An internal error occurred.';
    } catch (e) {
      return e.toString();
    }
  }
}
