import 'package:flutter/material.dart';
import 'package:poloniexapp/src/presentation/utils/sizeconfig.dart';


class Sizer extends StatefulWidget {
  const Sizer({super.key, required this.child});
  final Widget child;
  @override
  State<Sizer> createState() => _SizerState();
}

class _SizerState extends State<Sizer> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => LayoutBuilder(
        builder: (context, constraints) {
          SizeConfig.init(constraints, orientation);
          return widget.child;
        },
      ),
    );
  }
}
