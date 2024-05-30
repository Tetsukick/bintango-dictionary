import 'package:bintango_indonesian_dictionary/feature/auth/provider/auth_provider.dart';
import 'package:bintango_indonesian_dictionary/feature/auth/repository/token_repository.dart';
import 'package:bintango_indonesian_dictionary/feature/auth/state/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:bintango_indonesian_dictionary/app/state/app_start_state.dart';

part 'app_start_provider.g.dart';

@riverpod
class AppStartNotifier extends _$AppStartNotifier {
  late final TokenRepository _tokenRepository =
      ref.read(tokenRepositoryProvider);

  @override
  FutureOr<AppStartState> build() async {
    ref.onDispose(() {});

    return const AppStartState.authenticated();

    final authState = ref.watch(authNotifierProvider);

    if (authState is AuthStateLoggedIn) {
      return const AppStartState.authenticated();
    }

    if (authState is AuthStateLoggedOut) {
      return const AppStartState.unauthenticated();
    }

    final token = await _tokenRepository.fetchToken();
    if (token != null) {
      return const AppStartState.authenticated();
    } else {
      return const AppStartState.unauthenticated();
    }
  }
}
