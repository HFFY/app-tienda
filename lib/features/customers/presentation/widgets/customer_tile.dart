import 'package:flutter/material.dart';

import '../../../../core/widgets/inactive_chip.dart';
import '../../../../core/widgets/initials_avatar.dart';
import '../../domain/entities/customer.dart';

enum CustomerMenuAction { edit, toggleActive, delete }

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    super.key,
    required this.customer,
    required this.onTap,
    required this.onAction,
  });

  final Customer customer;
  final VoidCallback onTap;
  final ValueChanged<CustomerMenuAction> onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = customer;
    return ListTile(
      onTap: onTap,
      leading: InitialsAvatar(initials: c.initials, seed: c.fullName, muted: !c.isActive),
      title: Row(
        children: [
          Flexible(
            child: Text(
              c.fullName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: c.isActive ? null : scheme.outline),
            ),
          ),
          if (!c.isActive) ...[const SizedBox(width: 8), const InactiveChip()],
        ],
      ),
      subtitle: Text(c.hasPhone ? c.phone! : 'Sin teléfono'),
      trailing: PopupMenuButton<CustomerMenuAction>(
        tooltip: 'Opciones',
        onSelected: onAction,
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: CustomerMenuAction.edit,
            child: ListTile(leading: Icon(Icons.edit_outlined), title: Text('Editar')),
          ),
          PopupMenuItem(
            value: CustomerMenuAction.toggleActive,
            child: ListTile(
              leading: Icon(c.isActive ? Icons.visibility_off_outlined : Icons.visibility_outlined),
              title: Text(c.isActive ? 'Desactivar' : 'Activar'),
            ),
          ),
          const PopupMenuItem(
            value: CustomerMenuAction.delete,
            child: ListTile(leading: Icon(Icons.delete_outline), title: Text('Eliminar')),
          ),
        ],
      ),
    );
  }
}
