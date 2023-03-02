import 'package:flutter/material.dart';
import 'package:news_app_client/style/dimensions.dart';
import 'package:news_app_client/widgets/styled_dropdown_button.dart';
import 'package:sizing/sizing.dart';

class DropdownMenu<T> extends StatefulWidget {
  const DropdownMenu({
    Key? key,
    this.label,
    this.hint,
    this.items,
    required this.itemTitle,
    this.itemBuilder,
    this.selected,
    this.trailing,
    required this.onChange,
    this.onTap,
    this.onClear,
  }) : super(key: key);

  final String? label;
  final String? hint;
  final List<T>? items;
  final String Function(T) itemTitle;
  final Widget Function(T)? itemBuilder;
  final Widget? trailing;
  final T? selected;
  final ValueChanged<T> onChange;
  final VoidCallback? onTap;
  final VoidCallback? onClear;

  @override
  State<DropdownMenu<T>> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<DropdownMenu<T>> {
  @override
  Widget build(BuildContext context) {
    return StyledDropdownButton(
      label: widget.label ?? '',
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
          return;
        }
        if (widget.items != null) {
          _showItemsMenu(context);
        }
      },
      onClear: widget.onClear,
      selected: widget.selected != null
          ? widget.itemTitle(widget.selected as T)
          : null,
    );
  }

  Future<dynamic> _showItemsMenu(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        var theme = Theme.of(context);
        return SimpleDialog(
          title: widget.hint != null ? Text(widget.hint!) : null,
          titlePadding: paddingV8H12,
          titleTextStyle: theme.textTheme.headlineSmall,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          children: [
            SizedBox(
              height: 0.4.sh,
              width: 0.6.sw,
              child: ListView.builder(
                itemCount: widget.items!.length,
                itemBuilder: (context, index) {
                  final item = widget.items![index];
                  if (widget.itemBuilder != null) {
                    return widget.itemBuilder!(item);
                  }
                  return ListTile(
                    title: Text(widget.itemTitle(item)),
                    onTap: () {
                      widget.onChange(item);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
