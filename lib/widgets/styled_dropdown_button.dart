import 'package:flutter/material.dart';
import 'package:news_app_client/style/dimensions.dart';
import 'package:news_app_client/widgets/loading_indicator.dart';
import 'package:news_app_client/widgets/prefix_widget.dart';
import 'package:news_app_client/widgets/styled_card.dart';

class StyledDropdownButton extends StatelessWidget {
  const StyledDropdownButton({
    Key? key,
    required this.label,
    this.selected,
    required this.onTap,
    this.onClear,
    this.trailing,
    this.backgroundColor,
    this.isLoading = false,
    this.error,
    this.onRetry,
  })  : assert(
          !(error != null && isLoading),
          '"isLoading" can not be true while "error" is not null',
        ),
        assert(
          !(error != null && onRetry == null),
          '"error" and "onRetry" values should not be null when "isError" is true',
        ),
        super(key: key);

  final String label;
  final String? selected;
  final VoidCallback onTap;
  final VoidCallback? onClear;
  final Widget? trailing;
  final Color? backgroundColor;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return StyledCard(
      onTap: (isLoading || error != null) ? null : onTap,
      backgroundColor: backgroundColor,
      child: Row(
        children: [
          if (error != null) ...[
            const Icon(Icons.error_outline),
            sizedBoxW8,
          ],
          if (selected != null)
            PrefixText(
              text: label,
              usePrimaryColor: false,
            ),
          Text(
            selected ?? label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          trailing ?? _trailingIcon,
        ],
      ),
    );
  }

  Widget get _trailingIcon {
    if (error != null) {
      return IconButton(onPressed: onRetry, icon: const Icon(Icons.refresh));
    }
    if (isLoading) {
      return const StyledLoadingIndicator(width: 20);
    }
    if (selected != null && onClear != null) return _closeIcon;
    return _arrowDownIcon;
  }

  Icon get _arrowDownIcon => const Icon(Icons.keyboard_arrow_down);

  IconButton get _closeIcon => IconButton(
        onPressed: () => onClear!(),
        icon: const Icon(Icons.close),
        constraints: const BoxConstraints(minHeight: 26),
        padding: EdgeInsets.zero,
        iconSize: 20,
        splashRadius: 20,
      );
}
