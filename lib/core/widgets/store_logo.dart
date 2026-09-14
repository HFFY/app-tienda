import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import '../../features/store/presentation/providers/store_providers.dart';
import '../database/database_providers.dart';

const kStoreLogoHeroTag = 'store-logo';

/// Logo circular de la tienda (o sus iniciales). Comparte `Hero` entre el
/// login y el AppBar de Home.
class StoreLogo extends ConsumerWidget {
  const StoreLogo({super.key, this.size = 40, this.hero = true});

  final double size;
  final bool hero;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(storeControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    Widget avatar;
    if (store.hasLogo) {
      final file = File(p.join(ref.watch(documentsDirProvider).path, store.logoPath));
      avatar = ClipOval(
        child: Image.file(
          file,
          width: size,
          height: size,
          fit: BoxFit.cover,
          cacheWidth: (size * 3).round(),
          errorBuilder: (_, _, _) => _initials(store.initials, scheme),
        ),
      );
    } else {
      avatar = _initials(store.initials, scheme);
    }

    final sized = SizedBox(width: size, height: size, child: avatar);
    if (!hero) return sized;
    return Hero(tag: kStoreLogoHeroTag, child: sized);
  }

  Widget _initials(String initials, ColorScheme scheme) {
    return DecoratedBox(
      decoration: BoxDecoration(color: scheme.primary, shape: BoxShape.circle),
      child: Center(
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.all(size * 0.22),
            child: Text(
              initials,
              style: TextStyle(color: scheme.onPrimary, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
