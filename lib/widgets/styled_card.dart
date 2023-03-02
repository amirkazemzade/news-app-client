import 'package:flutter/material.dart';
import 'package:news_app_client/style/dimensions.dart';

class StyledCard extends StatelessWidget {
  const StyledCard({
    Key? key,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.contentPadding,
    this.backgroundColor,
    this.isSelected,
  }) : super(key: key);

  final Function()? onTap;
  final Function()? onLongPress;
  final Widget child;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      clipBehavior: Clip.antiAlias,
      elevation: isSelected == true ? 8 : null,
      child: Container(
        color: isSelected == true ? Theme.of(context).highlightColor : null,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: circular8,
          child: Padding(
            padding: contentPadding ?? padding8,
            child: child,
          ),
        ),
      ),
    );
  }
}
