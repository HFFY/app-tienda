import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../../core/widgets/password_field.dart';
import '../../../../core/widgets/store_logo.dart';
import '../../../store/presentation/providers/store_providers.dart';
import '../controllers/login_controller.dart';
import '../widgets/glass_card.dart';
import '../widgets/waves_background.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  /// Se incrementa en cada error para relanzar la animación de shake.
  int _shakeSeq = 0;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await ref
        .read(loginControllerProvider.notifier)
        .login(email: _email.text, password: _password.text);
    // El redirect del router lleva a Home cuando la sesión cambia.
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginControllerProvider, (prev, next) {
      if (next.hasError && !next.isLoading) setState(() => _shakeSeq++);
    });

    final state = ref.watch(loginControllerProvider);
    final storeName = ref.watch(storeControllerProvider.select((s) => s.name));
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final error = state.failureMessage;

    Widget card = GlassCard(
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: StoreLogo(size: 72)),
              const SizedBox(height: 16),
              Text(storeName, style: text.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text(
                'Ingresa para continuar',
                style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                validator: Validators.email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.mail_outline),
                ),
              ),
              const SizedBox(height: 16),
              PasswordField(
                controller: _password,
                validator: (v) => Validators.required(v, 'La contraseña'),
                autofillHints: const [AutofillHints.password],
                onFieldSubmitted: (_) => _submit(),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.topCenter,
                child: error == null
                    ? const SizedBox(width: double.infinity)
                    : Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          error,
                          style: text.bodySmall?.copyWith(color: scheme.error),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
              const SizedBox(height: 24),
              LoadingButton(
                label: 'Ingresar',
                loading: state.isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );

    if (_shakeSeq > 0) {
      card = card
          .animate(key: ValueKey(_shakeSeq))
          .shake(hz: 5, offset: const Offset(10, 0), duration: 450.ms);
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const WavesBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: card,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
