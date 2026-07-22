import 'package:flutter/material.dart';

import 'package:bloomtrack/core/constants.dart';
import 'package:bloomtrack/core/theme.dart';

/// A blood-color picker that shows a row of colored circles.
///
/// Each circle maps to a [BloodColor] enum value. Tapping a circle selects
/// it and displays the medical description below.
class ColorLegend extends StatelessWidget {
  const ColorLegend({
    required this.onChanged,
    this.selected,
    super.key,
  });

  /// Currently selected blood color (may be null).
  final BloodColor? selected;

  /// Called when the user taps a color swatch.
  final ValueChanged<BloodColor> onChanged;

  /// Maps each [BloodColor] to its display [Color].
  static Color _displayColor(BloodColor bloodColor) {
    switch (bloodColor) {
      case BloodColor.brightRed:
        return AppColors.bloodBrightRed;
      case BloodColor.darkRed:
        return AppColors.bloodDarkRed;
      case BloodColor.brown:
        return AppColors.bloodBrown;
      case BloodColor.pink:
        return AppColors.bloodPink;
      case BloodColor.orange:
        return AppColors.bloodOrange;
      case BloodColor.gray:
        return AppColors.bloodGray;
      case BloodColor.black:
        return AppColors.bloodBlack;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Color swatches row ──
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: BloodColor.values.map((bloodColor) {
            final isSelected = bloodColor == selected;
            final color = _displayColor(bloodColor);

            return GestureDetector(
              onTap: () => onChanged(bloodColor),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : Colors.transparent,
                    width: 3,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.4),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 20,
                      )
                    : null,
              ),
            );
          }).toList(),
        ),

        // ── Selected color label + description ──
        if (selected != null) ...[
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Card(
              key: ValueKey(selected),
              color: _displayColor(selected!).withValues(alpha: 0.08),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      margin: const EdgeInsets.only(top: 3),
                      decoration: BoxDecoration(
                        color: _displayColor(selected!),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selected!.label,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selected!.description,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.7),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
