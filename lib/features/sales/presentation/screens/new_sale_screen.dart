import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/money_text.dart';
import '../../domain/entities/sale.dart';
import '../providers/sale_providers.dart';
import '../widgets/cart_list.dart';
import '../widgets/customer_picker.dart';
import '../widgets/discount_section.dart';
import '../widgets/item_picker_sheet.dart';
import '../widgets/sale_success_dialog.dart';
import '../widgets/sale_summary_card.dart';

class NewSaleScreen extends ConsumerStatefulWidget {
  const NewSaleScreen({super.key});

  @override
  ConsumerState<NewSaleScreen> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends ConsumerState<NewSaleScreen> {
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    FocusScope.of(context).unfocus();
    final cart = ref.read(cartControllerProvider);
    final totals = ref.read(saleTotalsProvider);
    final text = Theme.of(context).textTheme;

    final ok = await showConfirmDialog(
      context,
      title: 'Confirmar venta',
      message: '',
      icon: Icons.point_of_sale,
      confirmLabel: 'Registrar',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cliente: ${cart.customer?.fullName ?? ''}'),
          Text('${cart.items.length} ítem${cart.items.length == 1 ? '' : 's'} · ${cart.unitCount} unidad${cart.unitCount == 1 ? '' : 'es'}'),
          if (totals.discountAmount > 0)
            Row(children: [const Text('Descuento: '), MoneyText(totals.discountAmount)]),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Total: ', style: text.titleMedium),
              MoneyText(totals.total, style: text.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Una vez registrada, la venta no podrá editarse ni anularse.',
            style: text.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ),
    );
    if (!ok || !mounted) return;

    ref.read(cartControllerProvider.notifier).setNote(_note.text);
    final result = await ref.read(registerSaleControllerProvider.notifier).register();
    if (!mounted) return;
    if (result.failure != null) {
      AppSnackBar.failure(context, result.failure!);
      return;
    }
    _note.clear();
    await showSaleSuccessDialog(context, result.sale!);
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartControllerProvider);
    final loading = ref.watch(registerSaleControllerProvider).isLoading;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              children: [
                _SectionTitle('1. Cliente', text),
                const CustomerSection(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _SectionTitle('2. Productos y servicios', text)),
                    TextButton.icon(
                      onPressed: cart.isEmpty ? null : () => ref.read(cartControllerProvider.notifier).clear(),
                      icon: const Icon(Icons.remove_shopping_cart_outlined, size: 18),
                      label: const Text('Vaciar'),
                    ),
                  ],
                ),
                Card(
                  child: Column(
                    children: [
                      if (cart.isEmpty)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                          child: Text(
                            'El carrito está vacío.',
                            style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        const CartList(),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => showItemPickerSheet(context, initialTab: SaleItemType.product),
                                icon: const Icon(Icons.inventory_2_outlined),
                                label: const Text('Productos'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => showItemPickerSheet(context, initialTab: SaleItemType.service),
                                icon: const Icon(Icons.design_services_outlined),
                                label: const Text('Servicios'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _SectionTitle('3. Descuento', text),
                const Card(
                  child: Padding(padding: EdgeInsets.all(12), child: DiscountSection()),
                ),
                const SizedBox(height: 20),
                _SectionTitle('4. Nota (opcional)', text),
                TextField(
                  controller: _note,
                  maxLines: 2,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(hintText: 'Observaciones de la venta'),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          SaleSummaryCard(enabled: cart.canRegister, loading: loading, onRegister: _register),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, this.text);

  final String title;
  final TextTheme text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(title, style: text.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
    );
  }
}
