import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SegmentedControl extends StatefulWidget {
  final List<String> values;
  final int initialPosition;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color borderColor;
  final double height;
  final double width;
  final Function(int index) onSelected;

  const SegmentedControl(
      {Key key,
      this.values,
      this.initialPosition,
      this.selectedColor,
      this.unSelectedColor,
      this.borderColor,
      this.height,
      this.width,
      this.onSelected})
      : super(key: key);

  @override
  _SegmentedControl createState() => _SegmentedControl();
}

class _SegmentedControl extends State<SegmentedControl> {
  int _current;
  Color _selectedColor;
  Color _unSelectedColor;
  Color _borderColor;
  double _height;
  double _width;

  @override
  void initState() {
    super.initState();
    _current = widget.initialPosition;
    _selectedColor = widget.selectedColor;
    _unSelectedColor = widget.unSelectedColor;
    _borderColor = widget.borderColor;
    _height = widget.height;
    _width = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.values.length,
        (index) {
          return GestureDetector(
            onTap: () async {
              setState(() => _current = index);
              widget.onSelected(index);
            },
            child: Container(
              height: _height,
              width: _width,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                border: Border.all(color: _borderColor),
                color: index == _current ? _selectedColor : _unSelectedColor,
              ),
              child: Text(widget.values[index],
                  style: TextStyle(
                      fontSize: 15,
                      color: index == _current
                          ? _unSelectedColor
                          : _selectedColor)),
            ),
          );
        },
      ),
    );
  }
}
