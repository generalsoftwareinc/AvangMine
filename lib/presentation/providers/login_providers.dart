import 'package:avangmine_riverpod/presentation/providers/api_tools.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'login_providers.g.dart';

final box = Hive.box('settings');

final loginNotifierProvider =
    StateNotifierProvider<LoginNotifier, StateLogin>((ref) {
  return LoginNotifier(ref);
});

class LoginNotifier extends StateNotifier<StateLogin> {
  LoginNotifier(this.ref) : super(StateLogin());
  final Ref ref;

  Future<void> initialized() async {
    final remember = box.get('remember', defaultValue: false);
    final isAuth = box.get('auth', defaultValue: false);
    if (remember) {
      final user = box.get('user', defaultValue: '');
      final pass = box.get('pass', defaultValue: '');
      final serv = box.get('server', defaultValue: '');
      ref.watch(formProvider.notifier).change(serv, user, pass);
      if (isAuth) {
        state = state.copyWith(loading: true);
        final String apiKey = box.get('apiKey', defaultValue: '');
        final split = serv.split('://');
        ref
            .watch(apiToolProvider.notifier)
            .initialized(apiKey, split[0], split[1]);
        final isAuthUser = await ref
            .read(autoLoginFetchProvider(ref.read(apiToolProvider)).future);
        if (isAuthUser != null) {
          state = state.copyWith(
              isAuth: true, loading: false, currentUser: isAuthUser);
        } else {
          state = state.copyWith(isAuth: false, loading: false, error: true);
        }
      }
    }
  }

  Future<void> auth() async {
    state = state.copyWith(loading: true);
    final stateForm = ref.watch(formProvider);
    final currentUser = await ref.read(loginFetchProvider(stateForm).future);
    if (currentUser != null) {
      final split = stateForm.server.split('://');
      ref
          .watch(apiToolProvider.notifier)
          .initialized(currentUser.apiKey!, split[0], split[1]);
      await box.put('auth', true);
      await box.put('apiKey', currentUser.apiKey);
      bool remember = box.get('remember', defaultValue: false);
      if (remember) {
        await box.put('user', stateForm.user);
        await box.put('pass', stateForm.password);
        await box.put('server', stateForm.server);
      }
      state = state.copyWith(
          isAuth: true, loading: false, currentUser: currentUser);
    } else {
      state = state.copyWith(isAuth: false, loading: false, error: true);
    }
  }

  void hidePassword() {
    state = state.copyWith(hidePassword: !state.hidePassword!);
  }
}

final formProvider = StateNotifierProvider<FormNotifier, StateFormLogin>((ref) {
  return FormNotifier();
});

class FormNotifier extends StateNotifier<StateFormLogin> {
  FormNotifier() : super(StateFormLogin());

  void change(String server, String user, String password) {
    state = state.copyWith(server: server, user: user, password: password);
  }
}

@riverpod
Future<User?> loginFetch(LoginFetchRef ref, StateFormLogin stateForm) async {
  return await loginService(
      stateForm.user, stateForm.password, stateForm.server);
}

@riverpod
Future<User?> autoLoginFetch(LoginFetchRef ref, ApiTools apiTools) async {
  return await verifyAuthService(apiTools);
}
