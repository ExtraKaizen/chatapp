import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey =
      "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";
  static const String _baseUrl =
      "https://api.groq.com/openai/v1/chat/completions";
  static const String _model = "llama3-8b-8192";

  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          "Authorization": "Bearer $_apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": _model,
          "messages": [
            {"role": "user", "content": message},
          ],
          "temperature": 0.7,
          "max_tokens": 1024,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['choices'][0]['message']['content'].trim();
      } else {
        throw _handleError(response.statusCode, response.body);
      }
    } catch (e) {
      throw "Failed to connect: ${e.toString()}";
    }
  }

  static String _handleError(int statusCode, String body) {
    switch (statusCode) {
      case 401:
        return "Unauthorized - Check API Key";
      case 429:
        return "Rate limit exceeded";
      case 400:
        return "Bad request: ${jsonDecode(body)['error']['message']}";
      default:
        return "API Error: $statusCode - ${jsonDecode(body)['error']['message']}";
    }
  }
}
