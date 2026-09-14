import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/money_formatter.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/app_info.dart';
import '../../../../core/error/result.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/image_picker_field.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../domain/entities/store.dart';
import '../controllers/demo_data_loader.dart';
import '../controllers/store_mutations.dart';
import '../providers/store_providers.dart';
import '../widgets/theme_selectors.dart';

class StoreSettingsScreen extends ConsumerStatefulWidget {
  const StoreSettingsScreen({super.key});

  @override
  ConsumerState<StoreSettingsScreen> createState() => _StoreSettingsScreenState();
}

class _StoreSettingsScreenState extends ConsumerState<StoreSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _address;
  late final TextEditingController _phone;
  late final TextEditingController _symbol;
  late final TextEditingController _code;
  late final TextEditingController _whatsapp;
  late String _locale;
  late int _decimals;
  XFile? _newLogo;
  bool _removeLogo = false;
  bool _loadingDemo = false;

  @override
  void initState() {
    super.initState();
    final s = ref.read(storeControllerProvider);
    _name = TextEditingController(text: s.name);
    _address = TextEditingController(text: s.address ?? '');
    _phone = TextEditingController(text: s.phone ?? '');
    _symbol = TextEditingController(text: s.currencySymbol);
    _code = TextEditingController(text: s.currencyCode);
    _whatsapp = TextEditingController(text: s.whatsappCountryCode);
    _locale = kSupportedNumberLocales.any((l) => l.code == s.numberLocale) ? s.numberLocale : 'es_BO';
    _decimals = s.decimalPlaces.clamp(0, 2);
  }

  @override
  void dispose() {
    for (final c in [_name, _address, _phone, _symbol, _code, _whatsapp]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final current = ref.read(storeControllerProvider);
    final draft = current.copyWith(
      name: _name.text,
      address: _address.text,
      phone: _phone.text,
      currencySymbol: _symbol.text,
      currencyCode: _code.text,
      numberLocale: _locale,
      decimalPlaces: _decimals,
      whatsappCountryCode: _whatsapp.text,
    );
    final failure = await ref
        .read(storeMutationsProvider.notifier)
        .save(draft, newLogo: _newLogo, removeLogo: _removeLogo);
    if (!mounted) return;
    if (failure != null) {
      AppSnackBar.failure(context, failure);
    } else {
      setState(() {
        _newLogo = null;
        _removeLogo = false;
      });
      AppSnackBar.show(context, 'Configuración guardada.');
    }
  }

  Future<void> _loadDemoData() async {
    final ok = await showConfirmDialog(
      context,
      title: 'Cargar datos de demostración',
      message: 'Se crearán clientes, productos, servicios y unas 60 ventas de los últimos 3 meses. '
          'Útil para probar los reportes. No se puede deshacer.',
      confirmLabel: 'Cargar',
      icon: Icons.science_outlined,
    );
    if (!ok || !mounted) return;
    setState(() => _loadingDemo = true);
    final result = await ref.read(demoDataLoaderProvider).load();
    if (!mounted) return;
    setState(() => _loadingDemo = false);
    switch (result) {
      case Ok(:final value):
        AppSnackBar.show(context, 'Datos cargados: $value ventas de demostración.');
      case Err(:final failure):
        AppSnackBar.failure(context, failure);
    }
  }

  Future<void> _backup() async {
    final failure = await ref.read(storeMutationsProvider.notifier).exportBackup();
    if (!mounted) return;
    if (failure != null) {
      AppSnackBar.failure(context, failure);
    } else {
      AppSnackBar.show(context, 'Respaldo generado. Guárdalo en un lugar seguro.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(storeControllerProvider);
    final busy = ref.watch(storeMutationsProvider).isLoading || _loadingDemo;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    // Vista previa con los valores del formulario (aún sin guardar).
    final preview = MoneyFormatter(
      locale: _locale,
      symbol: _symbol.text.trim().isEmpty ? _code.text.trim() : _symbol.text.trim(),
      decimals: _decimals,
    ).format(1234.5);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            _SectionTitle('Datos de la tienda'),
            ImagePickerField(
              existingPath: store.logoPath,
              placeholderIcon: Icons.storefront_outlined,
              size: 96,
              onChanged: ({newImage, required removed}) => setState(() {
                _newLogo = newImage;
                _removeLogo = removed;
              }),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              validator: (v) => Validators.required(v, 'El nombre'),
              decoration: const InputDecoration(labelText: 'Nombre de la tienda', prefixIcon: Icon(Icons.storefront_outlined)),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _address,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Dirección', prefixIcon: Icon(Icons.place_outlined)),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              validator: Validators.optionalPhone,
              decoration: const InputDecoration(labelText: 'Teléfono', prefixIcon: Icon(Icons.phone_outlined)),
            ),
            const SizedBox(height: 24),
            _SectionTitle('Apariencia'),
            const ThemeColorSelector(),
            const SizedBox(height: 12),
            const ThemeModeSelector(),
            const SizedBox(height: 24),
            _SectionTitle('Moneda y formato'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _symbol,
                    maxLength: 5,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(labelText: 'Símbolo', counterText: '', hintText: 'Bs'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _code,
                    maxLength: 3,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z]'))],
                    validator: (v) => (v == null || v.trim().length != 3) ? 'Código ISO de 3 letras.' : null,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(labelText: 'Código ISO', counterText: '', hintText: 'BOB'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _locale,
              decoration: const InputDecoration(labelText: 'Formato numérico'),
              items: [
                for (final l in kSupportedNumberLocales) DropdownMenuItem(value: l.code, child: Text(l.label)),
              ],
              onChanged: (v) => setState(() => _locale = v ?? _locale),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: _decimals,
                    decoration: const InputDecoration(labelText: 'Decimales'),
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('0')),
                      DropdownMenuItem(value: 1, child: Text('1')),
                      DropdownMenuItem(value: 2, child: Text('2')),
                    ],
                    onChanged: (v) => setState(() => _decimals = v ?? _decimals),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _whatsapp,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 4,
                    decoration: const InputDecoration(labelText: 'Cód. país WhatsApp', counterText: '', prefixText: '+'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: scheme.primaryContainer.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.visibility_outlined, size: 18, color: scheme.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Text('Así se verá: ', style: text.bodyMedium),
                  Text(preview, style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            LoadingButton(label: 'Guardar cambios', icon: Icons.check, loading: busy, onPressed: _save),
            const SizedBox(height: 28),
            _SectionTitle('Respaldo'),
            _BackupCard(store: store, busy: busy, onExport: _backup),
            const SizedBox(height: 28),
            _SectionTitle('Más'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.category_outlined),
                    title: const Text('Categorías'),
                    subtitle: const Text('Organiza productos y servicios'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(Routes.categories),
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Configuración de usuario'),
                    subtitle: const Text('Perfil, contraseña y cierre de sesión'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(Routes.storeUser),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Mantener presionado carga datos de demostración (para la demo).
            Center(
              child: GestureDetector(
                onLongPress: busy ? null : _loadDemoData,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'App Tienda · versión $kAppVersion',
                    style: text.bodySmall?.copyWith(color: scheme.outline),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackupCard extends StatelessWidget {
  const _BackupCard({required this.store, required this.busy, required this.onExport});

  final Store store;
  final bool busy;
  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final days = store.daysSinceBackup;
    final overdue = days == null || days > 30;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  overdue ? Icons.warning_amber_rounded : Icons.verified_outlined,
                  color: overdue ? Colors.orange.shade800 : Colors.green.shade700,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    store.lastBackupAt == null
                        ? 'Nunca se ha generado un respaldo.'
                        : 'Último respaldo: ${DateFormatter.dateTime(store.lastBackupAt!)} (${DateFormatter.relativeDays(store.lastBackupAt!)})',
                    style: text.bodyMedium,
                  ),
                ),
              ],
            ),
            if (overdue) ...[
              const SizedBox(height: 6),
              Text(
                'Se recomienda respaldar al menos una vez al mes.',
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              'Genera una copia de la base de datos (.db) y la comparte por email, WhatsApp, Drive u otra app.',
              style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            FilledButton.tonalIcon(
              onPressed: busy ? null : onExport,
              icon: const Icon(Icons.backup_outlined),
              label: const Text('Exportar respaldo'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
