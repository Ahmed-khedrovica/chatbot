import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/dependancy_injection.dart';
import 'package:flutter_application_1/features/chat/data/models/chat_message_model.dart';
import 'package:flutter_application_1/features/chat/data/models/chat_message_part_model.dart';
import 'package:flutter_application_1/features/chat/domain/chat_repo.dart';
import 'package:flutter_application_1/features/chat/ui/screens/chat_screen.dart';
import 'package:flutter_application_1/features/chat/ui/widgets/chat_message_bubble_widget.dart';
import 'package:flutter_application_1/features/chat/ui/widgets/failure_chat_message_bubble_widget.dart';
import 'package:flutter_application_1/features/chat/ui/widgets/loading_chat_message_bubble_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart';

class ChatMockrepo extends Mock implements ChatRepo {}

void main() {
  late ChatMockrepo chatMockRepo;

  setUp(() async {
    await getIt.reset();
    setupGetIt();
    await getIt.unregister<ChatRepo>();

    chatMockRepo = ChatMockrepo();
    getIt.registerLazySingleton<ChatRepo>(() => chatMockRepo);
  });

  patrolWidgetTest("Send message and show loading bubble widget", ($) async {
    when(
      () => chatMockRepo.sendMessage(messages: any(named: 'messages')),
    ).thenAnswer((_) {
      return Future.delayed(
        const Duration(seconds: 2),
        () => ChatMessageModel(
          parts: [ChatMessagePartModel(text: 'response')],
          role: 'model',
        ),
      );
    });

    await $.pumpWidgetAndSettle(const MaterialApp(home: ChatScreenWidget()));

    await $(TextField).enterText('hello');
    await $(Icons.send_rounded).tap();

    await $.pump();

    expect($(ChatMessageBubbleWidget), findsOneWidget);
    expect($(LoadingChatMessageBubbleWidget), findsOneWidget);
  });

  patrolWidgetTest("Send message and receive response message", ($) async {
    when(
      () => chatMockRepo.sendMessage(messages: any(named: 'messages')),
    ).thenAnswer((_) {
      return Future.delayed(
        const Duration(seconds: 2),
        () => ChatMessageModel(
          parts: [ChatMessagePartModel(text: 'response')],
          role: 'model',
        ),
      );
    });

    await $.pumpWidgetAndSettle(const MaterialApp(home: ChatScreenWidget()));

    await $(TextField).enterText('Hello');
    await $(Icons.send_rounded).tap();

    await $.pumpAndSettle();

    expect($(ChatMessageBubbleWidget).containing('Hello'), findsOneWidget);
    expect($(ChatMessageBubbleWidget).containing('response'), findsOneWidget);
  });

  patrolWidgetTest("Fails to send message", ($) async {
    when(
      () => chatMockRepo.sendMessage(messages: any(named: 'messages')),
    ).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      throw Exception();
    });

    await $.pumpWidgetAndSettle(const MaterialApp(home: ChatScreenWidget()));

    await $(TextField).enterText('Hello');
    await $(Icons.send_rounded).tap();

    await $.pumpAndSettle();

    expect(
      $(FailureChatMessageBubbleWidget).containing('Hello'),
      findsOneWidget,
    );
  });

  patrolWidgetTest("retry sending message and succeed", ($) async {
    var count = 0;

    when(
      () => chatMockRepo.sendMessage(messages: any(named: 'messages')),
    ).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));

      if (count == 1) {
        return ChatMessageModel(
          parts: [ChatMessagePartModel(text: 'response')],
          role: 'model',
        );
      }

      count++;
      throw Exception();
    });

    await $.pumpWidgetAndSettle(const MaterialApp(home: ChatScreenWidget()));

    await $(TextField).enterText('Hello');
    await $(Icons.send_rounded).tap();

    await $.pumpAndSettle();

    await $(Icons.refresh).tap();
    await $.pumpAndSettle();

    expect($(ChatMessageBubbleWidget).containing('Hello'), findsOneWidget);
    expect($(ChatMessageBubbleWidget).containing('response'), findsOneWidget);
  });

  patrolWidgetTest("send message and fails on 5th attempt", ($) async {
    var count = 0;

    when(
      () => chatMockRepo.sendMessage(messages: any(named: 'messages')),
    ).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));

      if (count == 4) {
        throw Exception();
      }

      count++;

      return ChatMessageModel(
        parts: [ChatMessagePartModel(text: 'response')],
        role: 'model',
      );
    });

    await $.pumpWidgetAndSettle(const MaterialApp(home: ChatScreenWidget()));

    for (int i = 0; i < 5; i++) {
      await $(TextField).enterText('Hello');
      await $(Icons.send_rounded).tap();
      await $.pumpAndSettle();
    }

    expect($(ChatMessageBubbleWidget).containing('Hello'), findsNWidgets(4));
    expect(
      $(FailureChatMessageBubbleWidget).containing('Hello'),
      findsOneWidget,
    );
  });
}
