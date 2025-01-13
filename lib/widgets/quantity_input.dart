import 'package:flutter/material.dart';

class QuantityInput extends StatefulWidget {
  final int? maxVal;
  final int? minVal;
  final int? initVal;
  final int? step;
  final void Function(int)? onChanged;

  QuantityInput({
    super.key,
    this.maxVal,
    this.minVal,
    this.initVal = 0,
    this.step = 1,
    this.onChanged,
  });

  @override
  State<QuantityInput> createState() => _QuantityInputState();
}

class _QuantityInputState extends State<QuantityInput> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    if((widget.initVal ?? 0) < (widget.minVal ?? 0)) {
      currentValue = widget.minVal ?? 0;
    } else if((widget.initVal ?? 0) > (widget.maxVal ?? 0)) {
      currentValue = widget.maxVal ?? 0;
    } else {
      currentValue = widget.initVal ?? 0;
    }
  }

  void _increment() {
    if (widget.onChanged != null) {
      widget.onChanged!(currentValue + widget.step!);
    }
    setState(() {
      currentValue = currentValue + widget.step!;
    });
  }

  void _decrement() {
    if (widget.onChanged != null) {
      widget.onChanged!(currentValue - widget.step!);
    }
    setState(() {
      currentValue = currentValue - widget.step!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton.filledTonal(

            onPressed: currentValue == widget.minVal ? null : _decrement,
            icon: Icon(Icons.remove)
        ),
        SizedBox(width: 2.0),
        Text(currentValue.toString()),
        SizedBox(width: 2.0),
        IconButton.filledTonal(
            onPressed: currentValue == widget.maxVal ? null : _increment,
            icon: Icon(Icons.add)
        ),
      ],
    );
  }
}