import 'package:flutter/material.dart';

import '../../../../core/utils/duration_formatter.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/category_chip.dart';
import '../../../../core/widgets/inactive_chip.dart';
import '../../../../core/widgets/money_text.dart';
import '../../domain/entities/service.dart';

enum ServiceMenuAction { edit, toggleActive, delete }

class ServiceTile extends StatelessWidget {
  const ServiceTile({
    super.key,
    required this.service,
    required this.onTap,
    required this.onAction,
  });

  final Service service;
  final VoidCallback onTap;
  final ValueChanged<ServiceMenuAction> onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final s = service;
    return ListTile(
      onTap: onTap,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 52,
          height: 52,
          child: AppImage(
            relativePath: s.imagePath,
            placeholderIcon: Icons.design_services_outlined,
            cacheWidth: 160,
          ),
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              s.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: s.isActive ? null : scheme.outline),
            ),
          ),
          if (!s.isActive) ...[const SizedBox(width: 8), const InactiveChip()],
        ],
      ),
      subtitle: Row(
        children: [
          Icon(Icons.schedule, size: 14, color: scheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(formatMinutes(s.durationMinutes)),
          const SizedBox(width: 10),
          Flexible(
            child: CategoryChip(
              name: s.categoryName,
              colorHex: s.categoryColorHex,
              iconCode: s.categoryIconCode,
              compact: true,
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MoneyText(s.price, style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w700)),
          PopupMenuButton<ServiceMenuAction>(
            tooltip: 'Opciones',
            onSelected: onAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ServiceMenuAction.edit,
                child: ListTile(leading: Icon(Icons.edit_outlined), title: Text('Editar')),
              ),
              PopupMenuItem(
                value: ServiceMenuAction.toggleActive,
                child: ListTile(
                  leading: Icon(s.isActive ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                  title: Text(s.isActive ? 'Desactivar' : 'Activar'),
                ),
              ),
              const PopupMenuItem(
                value: ServiceMenuAction.delete,
                child: ListTile(leading: Icon(Icons.delete_outline), title: Text('Eliminar')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
