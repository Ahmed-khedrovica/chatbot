import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/networking/api_client.dart';
import 'package:flutter_application_1/features/chat/data/models/chat_message_model.dart';
import 'package:flutter_application_1/features/chat/data/services/gemenai_chat_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late GemenaiChatService gemenaiChatService;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    gemenaiChatService = GemenaiChatService(apiClient: mockApiClient);
  });

  group('Gemenai chat service tests', () {

    test('does not retry on 400 error', () async {

      when(() => mockApiClient.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 400,
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(
            () => gemenaiChatService.sendMessage(
          messages: [ChatMessageModel(role: 'user', parts: [])],
        ),
        throwsA(isA<DioException>()),
      );

      verify(() => mockApiClient.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      )).called(1);
    });

    test('retries twice then succeeds', () async {

      int callCount = 0;

      when(() => mockApiClient.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      )).thenAnswer((_) async {
        callCount++;

        if (callCount < 3) {
          throw DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
          );
        }

        return {
          "candidates": [
            {
              "content": {
                "role": "model",
                "parts": [
                  {"text": "Success"}
                ]
              }
            }
          ]
        };
      });

      final result = await gemenaiChatService.sendMessage(
        messages: [ChatMessageModel(role: 'user', parts: [])],
      );

      expect(result.role, 'model');
      expect(callCount, 3);
    });

    test('fails after max retries', () async {
      when(() => mockApiClient.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionError,
        ),
      );

      await expectLater(
        gemenaiChatService.sendMessage(
          messages: [ChatMessageModel(role: 'user', parts: [])],
        ),
        throwsA(isA<DioException>()),
      );

      verify(() => mockApiClient.post(
        any(),
        data: any(named: 'data'),
        options: any(named: 'options'),
      )).called(3);
    });

  });
}

class MockApiClient extends Mock implements DioApiClient {}
