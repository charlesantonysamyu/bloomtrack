import 'package:flutter/material.dart';

import 'package:bloomtrack/core/constants.dart';
import 'package:bloomtrack/core/theme.dart';

/// A horizontal selector for flow intensity levels.
///
/// Displays four tappable options (Spotting → Heavy) with increasing
/// numbers of water-drop icons. The selected option gets a colored
/// background to indicate active state.
class FlowPicker extends StatelessWidget {
  const FlowPicker({
    required this.onChanged,
    this.selected,
    super.key,
  });

  /// Currently selected flow level (may be null if nothing is selected).
  final FlowLevel? selected;

  /// Called when the user taps a flow level.
  final ValueChanged<FlowLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: FlowLevel.values.map((level) {
        final isSelected = level == selected;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: level != FlowLevel.heavy ? 8 : 0,
            ),
            child: _FlowChip(
              level: level,
              isSelected: isSelected,
              onTap: () => onChanged(level),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// A single flow-level chip with icon(s) and label.
class _FlowChip extends StatelessWidget {
  const _FlowChip({
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  final FlowLevel level;
  final bool isSelected;
  final VoidCallback onTap;

  /// Maps each flow level to its corresponding theme color.
  Color get _color {
    switch (level) {
      case FlowLevel.spotting:
        return AppColors.flowSpotting;
      case FlowLevel.light:
        return AppColors.flowLight;
      case FlowLevel.medium:
        return AppColors.flowMedium;
      case FlowLevel.heavy:
        return AppColors.flowHeavy;
    }
  }

  /// Number of droplet icons to display.
  int get _dropletCount {
    switch (level) {
      case FlowLevel.spotting:
        return 1;
      case FlowLevel.light:
        return 2;
      case FlowLevel.medium:
        return 3;
      case FlowLevel.heavy:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = _color;

    return Material(
      color: isSelected
          ? activeColor.withValues(alpha: 0.18)
          : theme.colorScheme.onSurface.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? activeColor.withValues(alpha: 0.5)
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Droplet icons row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  _dropletCount,
                  (_) => Icon(
                    Icons.water_drop_rounded,
                    size: 16,
                    color: isSelected
                        ? activeColor
                        : theme.colorScheme.onSurface
                            .withValues(alpha: 0.35),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                level.label,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? activeColor
                      : theme.colorScheme.onSurface
                          .withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
