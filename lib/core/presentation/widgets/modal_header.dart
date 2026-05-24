import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ModalHeader extends StatelessWidget {
  const ModalHeader({
    required this.title,
    required this.onClose,
  });

  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 18),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }
}

class ModalFooter extends StatelessWidget {
  const ModalFooter({super.key, this.saveText, required this.onSave,
  required this.isLoading});

  final String? saveText;
  final VoidCallback? onSave;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        border: Border(
          top: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Cancel
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              side: BorderSide(
                color: colors.outlineVariant,
                width: 0.5,
              ),
              foregroundColor: colors.onSurfaceVariant,
            ),
            child: const Text('Cancel',
                style: TextStyle(fontSize: 13)),
          ),
          const SizedBox(width: 10),

          // Save
         FilledButton(
              onPressed: onSave,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: isLoading
                  ? const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text('Proceed',
                  style: TextStyle(fontSize: 13)),
            ),

        ],
      ),
    );
  }
}