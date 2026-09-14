import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_options.dart';
import '../providers/store_providers.dart';

/// Tres círculos de color que aplican el tema **en vivo** (MaterialApp
/// anima la transición) y lo persisten en `store`.
class ThemeColorSelector extends ConsumerWidget {
  const ThemeColorSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(themeColorProvider);
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        for (final option in ThemeColorOption.values)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Semantics(
                  button: true,
                  selected: option == current,
                  label: 'Tema ${option.label}',
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => ref.read(storeControllerProvider.notifier).setThemeColor(option),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.seedOf(option),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: option == current ? scheme.onSurface : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: option == current ? const Icon(Icons.check, color: Colors.white) : null,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(option.label, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
      ],
    );
  }
}

class ThemeModeSelector extends ConsumerWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(themeModeOptionProvider);
    return SegmentedButton<ThemeModeOption>(
      segments: const [
        ButtonSegment(value: ThemeModeOption.light, label: Text('Claro'), icon: Icon(Icons.light_mode_outlined)),
        ButtonSegment(value: ThemeModeOption.dark, label: Text('Oscuro'), icon: Icon(Icons.dark_mode_outlined)),
        ButtonSegment(value: ThemeModeOption.system, label: Text('Sistema'), icon: Icon(Icons.phone_android)),
      ],
      selected: {current},
      showSelectedIcon: false,
      onSelectionChanged: (s) => ref.read(storeControllerProvider.notifier).setThemeMode(s.first),
    );
  }
}
