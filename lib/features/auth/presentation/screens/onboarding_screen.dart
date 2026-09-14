import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../../core/widgets/password_field.dart';
import '../controllers/login_controller.dart';
import '../controllers/onboarding_controller.dart';

/// Primera ejecución: crea la cuenta única y nombra la tienda.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storeName = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    for (final c in [_storeName, _firstName, _lastName, _email, _password, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await ref.read(onboardingControllerProvider.notifier).register(
          firstName: _firstName.text,
          lastName: _lastName.text,
          email: _email.text,
          password: _password.text,
          storeName: _storeName.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final error = state.failureMessage;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.storefront, size: 56, color: scheme.primary),
                    const SizedBox(height: 12),
                    Text('¡Bienvenido!', style: text.headlineMedium, textAlign: TextAlign.center),
                    const SizedBox(height: 4),
                    Text(
                      'Configura tu tienda y crea tu cuenta para empezar.',
                      style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    Text('Tu tienda', style: text.titleMedium),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _storeName,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      validator: (v) => Validators.required(v, 'El nombre de la tienda'),
                      decoration: const InputDecoration(
                        labelText: 'Nombre de la tienda',
                        prefixIcon: Icon(Icons.storefront_outlined),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Tu cuenta', style: text.titleMedium),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstName,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            validator: (v) => Validators.required(v, 'El nombre'),
                            decoration: const InputDecoration(labelText: 'Nombre'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _lastName,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            validator: (v) => Validators.required(v, 'El apellido'),
                            decoration: const InputDecoration(labelText: 'Apellido'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: Validators.email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: _password,
                      textInputAction: TextInputAction.next,
                      validator: Validators.password,
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: _confirm,
                      label: 'Confirmar contraseña',
                      validator: (v) => Validators.confirmPassword(v, _password.text),
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    if (error != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        error,
                        style: text.bodySmall?.copyWith(color: scheme.error),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 24),
                    LoadingButton(
                      label: 'Crear cuenta',
                      icon: Icons.check,
                      loading: state.isLoading,
                      onPressed: _submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
