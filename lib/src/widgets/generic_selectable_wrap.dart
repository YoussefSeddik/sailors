import 'package:flutter/material.dart';

class GenericSelectableWrap<T> extends StatelessWidget {
  final List<T> items;
  final int? selectedIndex;
  final String Function(T) getLabelLeft;
  final String Function(T) getLabelRight;
  final ValueChanged<int> onSelected;

  const GenericSelectableWrap({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.getLabelLeft,
    required this.getLabelRight,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(items.length, (index) {
        final item = items[index];
        final isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () => onSelected(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE6F9FD) : Colors.transparent,
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getLabelLeft(item),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    getLabelRight(item),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

