import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/initials_avatar.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../../core/widgets/password_field.dart';
import '../../domain/entities/app_user.dart';
import '../controllers/user_settings_controller.dart';
import '../providers/auth_providers.dart';

class UserSettingsScreen extends ConsumerStatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  ConsumerState<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends ConsumerState<UserSettingsScreen> {
  final _profileKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  bool _hydrated = false;

  @override
  void dispose() {
    for (final c in [_firstName, _lastName, _email, _current, _next, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  void _hydrate(AppUser u) {
    if (_hydrated) return;
    _hydrated = true;
    _firstName.text = u.firstName;
    _lastName.text = u.lastName;
    _email.text = u.email;
  }

  Future<void> _saveProfile(AppUser user) async {
    if (!_profileKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final failure = await ref.read(userMutationsProvider.notifier).updateProfile(
          user.copyWith(firstName: _firstName.text, lastName: _lastName.text, email: _email.text),
        );
    if (!mounted) return;
    if (failure != null) {
      AppSnackBar.failure(context, failure);
    } else {
      AppSnackBar.show(context, 'Perfil actualizado.');
    }
  }

  Future<void> _changePassword(AppUser user) async {
    if (!_passwordKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final failure = await ref.read(userMutationsProvider.notifier).changePassword(
          userId: user.id,
          current: _current.text,
          next: _next.text,
          confirm: _confirm.text,
        );
    if (!mounted) return;
    if (failure != null) {
      AppSnackBar.failure(context, failure);
    } else {
      _current.clear();
      _next.clear();
      _confirm.clear();
      AppSnackBar.show(context, 'Contraseña actualizada.');
    }
  }

  Future<void> _logout() async {
    final ok = await showConfirmDialog(
      context,
      title: 'Cerrar sesión',
      message: 'Tendrás que ingresar tu email y contraseña para volver a entrar.',
      confirmLabel: 'Cerrar sesión',
      icon: Icons.logout,
      destructive: true,
    );
    if (!ok) return;
    await ref.read(sessionControllerProvider.notifier).logout();
    // El redirect del router lleva al login y desmonta esta pantalla.
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final busy = ref.watch(userMutationsProvider).isLoading;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final user = userAsync.value;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Configuración de usuario')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    _hydrate(user);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración de usuario')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          Row(
            children: [
              InitialsAvatar(initials: user.initials, seed: user.fullName, size: 56),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.fullName, style: text.titleLarge),
                    Text(user.email, style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Perfil', style: text.titleMedium),
          const SizedBox(height: 10),
          Form(
            key: _profileKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstName,
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => Validators.required(v, 'El nombre'),
                        decoration: const InputDecoration(labelText: 'Nombre'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _lastName,
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => Validators.required(v, 'El apellido'),
                        decoration: const InputDecoration(labelText: 'Apellido'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline)),
                ),
                const SizedBox(height: 12),
                LoadingButton(label: 'Guardar perfil', icon: Icons.check, loading: busy, onPressed: () => _saveProfile(user)),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text('Cambiar contraseña', style: text.titleMedium),
          const SizedBox(height: 10),
          Form(
            key: _passwordKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PasswordField(
                  controller: _current,
                  label: 'Contraseña actual',
                  textInputAction: TextInputAction.next,
                  validator: (v) => Validators.required(v, 'La contraseña actual'),
                ),
                const SizedBox(height: 12),
                PasswordField(
                  controller: _next,
                  label: 'Nueva contraseña',
                  textInputAction: TextInputAction.next,
                  validator: Validators.password,
                ),
                const SizedBox(height: 12),
                PasswordField(
                  controller: _confirm,
                  label: 'Confirmar nueva contraseña',
                  validator: (v) => Validators.confirmPassword(v, _next.text),
                  onFieldSubmitted: (_) => _changePassword(user),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: busy ? null : () => _changePassword(user),
                  icon: const Icon(Icons.lock_reset),
                  label: const Text('Actualizar contraseña'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(foregroundColor: scheme.error),
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
