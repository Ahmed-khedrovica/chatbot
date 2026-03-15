import 'package:flutter_application_1/features/chat/data/repos/gemenai_chat_repo_impl.dart';
import 'package:flutter_application_1/features/chat/data/services/gemenai_chat_service.dart';
import 'package:get_it/get_it.dart';

import '../../features/chat/domain/chat_repo.dart';
import '../../features/chat/ui/cubits/chat_cubit/chat_cubit.dart';
import '../networking/api_client.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Api Client
  getIt.registerSingleton<DioApiClient>(DioApiClient());

  // Service
  getIt.registerLazySingleton<GemenaiChatService>(
    () => GemenaiChatService(apiClient: getIt<DioApiClient>()),
  );

  // Repo
  getIt.registerLazySingleton<ChatRepo>(
    () => GemenaiChatRepoImpl(gemenaiChatService: getIt<GemenaiChatService>()),
  );

  // Cubit
  getIt.registerFactory<SendMessageCubit>(
    () => SendMessageCubit(chatRepo: getIt<ChatRepo>()),
  );
}
