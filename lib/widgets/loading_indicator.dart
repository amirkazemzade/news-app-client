import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sizing/sizing_extension.dart';

class StyledLoadingIndicator extends StatelessWidget {
  const StyledLoadingIndicator({Key? key, this.width, this.color})
      : super(key: key);

  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width ?? 60.ss,
        child: LoadingIndicator(
          indicatorType: Indicator.ballBeat,
          colors: [color ?? Theme.of(context).colorScheme.primary],
          strokeWidth: 1,
        ),
      ),
    );
  }
}
