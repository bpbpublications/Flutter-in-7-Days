import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final String title;
  final String? preText;
  final double minValue;
  final double maxValue;
  final double initialValue;
  final ValueChanged<double>? onValueChanged; // Callback function

  const CustomSlider({
    required this.title,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    Key? key,
    this.preText,
    this.onValueChanged, // Callback function parameter
  }) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 50;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    if (widget.onValueChanged != null) {
      widget
          .onValueChanged!(_value); // Call the callback with the initial value
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0XFFD6EAF8),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: const Color(0XFF99B7D1),
          inactiveTrackColor: const Color(0XFF99B7D1),
          thumbColor: const Color(0XFF004C8E),
          valueIndicatorTextStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 15),
              ),
              Slider(
                value: _value,
                min: widget.minValue,
                max: widget.maxValue,
                divisions: (widget.maxValue - widget.minValue) ~/ 1,
                label: widget.preText != null
                    ? '${widget.preText} ${_value.toStringAsFixed(0)}'
                    : _value.toStringAsFixed(0),
                onChanged: (newValue) {
                  setState(() {
                    _value = newValue;
                  });
                  if (widget.onValueChanged != null) {
                    widget.onValueChanged!(
                        _value); // Call the callback with the updated value
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (widget.preText != null
                        ? '${widget.preText} ${widget.minValue.toStringAsFixed(0)}'
                        : widget.minValue.toStringAsFixed(0)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.preText != null
                        ? '${widget.preText} ${_value.toStringAsFixed(0)}'
                        : _value.toStringAsFixed(0),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  Text(
                    (widget.preText != null
                        ? '${widget.preText} ${widget.minValue.toStringAsFixed(0)}'
                        : widget.maxValue.toStringAsFixed(0)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
