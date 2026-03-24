import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:flutter/cupertino.dart';

class CustomProgressBarWidget extends StatefulWidget {
  final double value;
  const CustomProgressBarWidget({super.key, required this.value});

  @override
  State<CustomProgressBarWidget> createState() => _CustomProgressBarWidget();
}

class _CustomProgressBarWidget extends State<CustomProgressBarWidget> {
  late double _currentSliderValue;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoProgressBar(
        value: _currentSliderValue,
        trackColor: null,
        semanticsValue: _currentSliderValue.toString());
  }
}
