import 'package:flutter/material.dart';
import 'package:news_app_client/style/dimensions.dart';
import 'package:news_app_client/widgets/check_box_tile.dart';
import 'package:news_app_client/widgets/styled_dropdown_button.dart';
import 'package:sizing/sizing.dart';

class MultiSelectDropdownMenu<T> extends StatelessWidget {
  const MultiSelectDropdownMenu({
    Key? key,
    this.label,
    this.hint,
    this.items,
    required this.itemTitle,
    this.itemBuilder,
    this.itemTrailing,
    required this.selected,
    required this.onChange,
    this.isLoading = false,
    this.error,
    this.onRetry,
  }) : super(key: key);

  final String? label;
  final String? hint;
  final List<T>? items;
  final String Function(T) itemTitle;
  final Widget Function(T)? itemBuilder;
  final Widget Function(T)? itemTrailing;
  final List<T> selected;
  final ValueChanged<List<T>> onChange;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return StyledDropdownButton(
      label: label ?? '',
      onTap: () => _showItemsMenu(context),
      isLoading: isLoading,
      error: error,
      onRetry: onRetry,
    );
  }

  Future<dynamic> _showItemsMenu(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return MultiSelectDialog<T>(
          theme: Theme.of(context),
          hint: hint,
          items: items,
          itemBuilder: itemBuilder,
          selected: selected,
          itemTitle: itemTitle,
          onChange: onChange,
          itemTrailing: itemTrailing,
        );
      },
    );
  }
}

class MultiSelectDialog<T> extends StatefulWidget {
  const MultiSelectDialog({
    Key? key,
    required this.theme,
    required this.hint,
    required this.items,
    required this.itemBuilder,
    required this.itemTitle,
    required this.itemTrailing,
    required this.selected,
    required this.onChange,
  }) : super(key: key);

  final ThemeData theme;
  final String? hint;
  final List? items;
  final Widget Function(T)? itemBuilder;
  final String Function(T) itemTitle;
  final Widget Function(T)? itemTrailing;
  final List<T> selected;
  final ValueChanged<List<T>> onChange;

  @override
  State<MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  late List<T> _tempSelectedList;

  @override
  void initState() {
    _tempSelectedList = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: widget.hint != null ? Text(widget.hint!) : null,
      titlePadding: paddingV8H12,
      titleTextStyle: widget.theme.textTheme.titleLarge,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      children: [
        Column(
          children: [
            SizedBox(
              height: 0.5.sh,
              width: 1.sw,
              child: ListView.builder(
                itemCount: widget.items!.length,
                itemBuilder: (context, index) {
                  final item = widget.items![index];
                  if (widget.itemBuilder != null) {
                    return widget.itemBuilder!(item);
                  }
                  var isItemSelected = _tempSelectedList.contains(item);
                  return _chipItem(item, isItemSelected);
                },
              ),
            ),
            sizedBoxH4,
            Row(
              children: [
                sizedBoxW8,
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("cancel"),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      widget.onChange(_tempSelectedList);
                      Navigator.of(context).pop();
                    },
                    child: const Text("ok"),
                  ),
                ),
                sizedBoxW8,
              ],
            ),
            sizedBoxH8,
          ],
        ),
      ],
    );
  }

  Widget _chipItem(item, bool isItemSelected) {
    return CheckBoxTile(
      title: widget.itemTitle(item),
      value: isItemSelected,
      onChanged: (bool? value) => _setItemSelection(item, isItemSelected),
      actionOnCheckBoxOnly: false,
    );
  }

  void _setItemSelection(item, bool isItemSelected) {
    late List<T> updatedSelected;
    if (!isItemSelected) {
      updatedSelected = <T>[..._tempSelectedList, item];
    } else {
      updatedSelected = _tempSelectedList.toList()..remove(item);
    }
    setState(() {
      _tempSelectedList = updatedSelected;
    });
  }
}
