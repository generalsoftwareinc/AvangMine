import 'package:avangmine_riverpod/config/config.dart';
import 'package:avangmine_riverpod/presentation/providers/login_providers.dart';
import 'package:avangmine_riverpod/presentation/screens/login/widgets/error_login.dart';
import 'package:avangmine_riverpod/presentation/screens/widgets_common/widgets_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tabler_icons/tabler_icons.dart';

class FormLogin extends StatefulHookConsumerWidget {
  const FormLogin({super.key});

  @override
  ConsumerState<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends ConsumerState<FormLogin> {
  final box = Hive.box('settings');
  final controllerServer = TextEditingController();
  final controllerUser = TextEditingController();
  final controllerPass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(loginNotifierProvider.notifier).initialized();
      controllerServer.text = ref.read(formProvider).server;
      controllerUser.text = ref.read(formProvider).user;
      controllerPass.text = ref.read(formProvider).password;
      if (ref.read(loginNotifierProvider).isAuth!) {
        ref.read(appRouterRefProvider).pushReplacement('/home');
      }
    });
  }

  Future<void> _onSubmit() async {
    final isOK = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isOK) {
      ref.read(formProvider.notifier).change(controllerServer.text.trim(),
          controllerUser.text.trim(), controllerPass.text.trim());
      await ref.read(loginNotifierProvider.notifier).auth();
      if (ref.read(loginNotifierProvider).isAuth!) {
        ref.read(appRouterRefProvider).pushReplacement('/home');
      }
    }
  }

  @override
  void dispose() {
    controllerServer.dispose();
    controllerUser.dispose();
    controllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: theme.onSurface);

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Login', style: textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'Enter your credentials to access the platform',
              style: textTheme.bodyLarge!.copyWith(color: theme.outline),
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                final error = ref.watch<bool>(
                    loginNotifierProvider.select((state) => state.error!));
                return error
                    ? const ErrorLoginWidget()
                    : const SizedBox.shrink();
              },
            ),
            MyInputText(
              text: 'Server',
              controller: controllerServer,
              prefixIcon: const Icon(TablerIcons.server),
              keyboardType: TextInputType.url,
              validator: (value) =>
                  Validators.url(value!) ? null : 'Invalid server',
            ),
            const SizedBox(height: 16),
            MyInputText(
              text: 'Username',
              controller: controllerUser,
              prefixIcon: const Icon(TablerIcons.user),
              suffixIcon: ClearButton(controller: controllerUser),
              keyboardType: TextInputType.name,
              validator: (value) =>
                  Validators.userName(value!) ? null : 'Invalid username',
            ),
            const SizedBox(height: 16),
            Consumer(builder: (context, ref, child) {
              final hidePassword = ref.watch<bool>(
                  loginNotifierProvider.select((state) => state.hidePassword!));
              return MyInputText(
                text: 'Password',
                controller: controllerPass,
                obscureText: hidePassword,
                enableSuggestions: false,
                autocorrect: false,
                prefixIcon: const Icon(TablerIcons.lock),
                keyboardType: TextInputType.text,
                validator: (value) =>
                    Validators.password(value!) ? null : 'Invalid Password',
                suffixIcon: IconButton(
                    icon: Icon(
                        hidePassword ? TablerIcons.eye : TablerIcons.eye_off),
                    onPressed: () {
                      ref.read(loginNotifierProvider.notifier).hidePassword();
                    }),
              );
            }),
            const SizedBox(height: 8),
            Consumer(
              builder: (context, ref, child) {
                final loading = ref.watch<bool>(
                    loginNotifierProvider.select((state) => state.loading!));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: box.listenable(keys: ['remember']),
                      builder: (_, box, __) {
                        return CheckboxListTile.adaptive(
                          enabled: !loading,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: box.get('remember', defaultValue: false),
                          title: const Text('Remember credentials'),
                          onChanged: (value) async {
                            await box.put('remember', value);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      icon: Text(
                        'Login',
                        style: textTheme.titleMedium!.copyWith(
                            color: loading ? theme.primary : theme.onPrimary),
                      ),
                      style: FilledButton.styleFrom(
                        disabledBackgroundColor: theme.primaryContainer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: loading ? null : _onSubmit,
                      label: loading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(theme.primary),
                              ),
                            )
                          : const Icon(TablerIcons.arrow_right, size: 20)
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .moveX(begin: 10, duration: 800.ms),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
