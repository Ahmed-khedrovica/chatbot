import 'package:dio/dio.dart';

import '../../../../core/networking/api_client.dart';
import '../models/chat_message_model.dart';

class GemenaiChatService {
  final DioApiClient _apiClient;

  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';

  GemenaiChatService({required DioApiClient apiClient})
    : _apiClient = apiClient;

  Future<ChatMessageModel> sendMessage({
    required List<ChatMessageModel> messages,
  }) async {
    const maxRetries = 3;
    int attempt = 0;

    while (true) {
      try {
        final response = await _apiClient.post(
          '$_baseUrl/gemini-3-flash-preview:generateContent',
          data: {
            "contents": messages.map((message) => message.toJson()).toList(),
          },
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "x-goog-api-key": "AIzaSyCFEthQWk1qLZujuvXXUWg0O2nYcE-z00M",
            },
          ),
        );

        return ChatMessageModel.fromJson(response['candidates'][0]['content']);
      } on DioException catch (error) {
        attempt++;

        final shouldRetry =
            error.type == DioExceptionType.connectionError ||
            error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            (error.response?.statusCode != null &&
                error.response!.statusCode! >= 500);

        if (attempt >= maxRetries || !shouldRetry) {
          rethrow;
        }

        await Future.delayed(Duration(milliseconds: 300 * attempt));
      }
    }
  }
}
