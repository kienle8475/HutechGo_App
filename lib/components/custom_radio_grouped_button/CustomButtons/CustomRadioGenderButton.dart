import 'package:flutter/material.dart';
import 'package:hutech_go/models/campus.dart';
import '../custom_radio_grouped_button.dart';

// ignore: must_be_immutable
class CustomRadioCampusButton<T> extends StatefulWidget {
  CustomRadioCampusButton({
    Key key,
    this.horizontal = false,
    this.buttonTextStyle = const ButtonTextStyle(),
    this.height = 35,
    this.padding = 3,
    this.spacing = 0.0,
    this.autoWidth = false,
    this.width = 100,
    this.enableShape = false,
    this.elevation = 0,
    //
    this.campuses,
    this.checkBoxButtonValues,
    //
    this.selectedColor,
    this.selectedBorderColor,
    this.wrapAlignment = WrapAlignment.start,
    this.defaultSelected,
    this.unSelectedColor,
    this.unSelectedBorderColor,
    this.customShape,
    this.absoluteZeroSpacing = false,
    this.enableButtonWrap = false,
  });
  // assert(buttonLables.length == buttonValuesList.length,
  //     "Button values list and button lables list should have same number of eliments "),
  // assert(unSelectedColor != null, "Unselected color cannot be null"),
  // assert(buttonValuesList.toSet().length == buttonValuesList.length,
  //     "Multiple buttons with same value cannot exist"),
  // assert(buttonLables.toSet().length == buttonLables.length,
  //     "Multiple buttons label wth same value cannot exist"),
  // assert(selectedColor != null, "Selected color cannot be null");
  // assert(campuses.length != null, "Campuses cannot be null");

  ///Orientation of the Button Group
  final bool horizontal;

  ///This option will make sure that there is no spacing in between buttons
  final bool absoluteZeroSpacing;

  ///Values of button

  ///Styling class for label
  final ButtonTextStyle buttonTextStyle;

  ///Default value is 35
  final double height;
  double padding;

  ///Spacing between buttons
  double spacing;

  ///Only applied when in vertical mode
  ///This will use minimum space required
  ///If enables it will ignore [width] field
  final bool autoWidth;

  ///Use this if you want to keep width of all the buttons same
  final double width;

  ///if true button will have rounded corners
  ///If you want custom shape you can use [customShape] property
  final bool enableShape;
  final double elevation;

  //
  final List<Campus> campuses;
  final void Function(int) checkBoxButtonValues;

  ///Selected Color of button
  final Color selectedColor;

  ///Selected Color of button border
  final Color selectedBorderColor;

  ///alignment for button when [enableButtonWrap] is true
  final WrapAlignment wrapAlignment;

  ///Default Selected button
  final T defaultSelected;

  ///Unselected Color of the button
  final Color unSelectedColor;

  ///Unselected Color of the button border
  final Color unSelectedBorderColor;

  /// A custom Shape can be applied (will work only if [enableShape] is true)
  final ShapeBorder customShape;

  /// This will enable button wrap (will work only if orientation is vertical)
  final bool enableButtonWrap;

  _CustomRadioCampusButtonState createState() =>
      _CustomRadioCampusButtonState();
}

class _CustomRadioCampusButtonState extends State<CustomRadioCampusButton> {
  int selectedIndex;
  Color borderColor(e) =>
      (selectedIndex == e
          ? widget.selectedBorderColor
          : widget.unSelectedBorderColor) ??
      Theme.of(context).primaryColor;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildButtonsRow() {
    return widget.campuses.map((e) {
      int index = widget.campuses.indexOf(e);
      return Card(
        margin: EdgeInsets.all(widget.absoluteZeroSpacing ? 0 : 4),
        color: selectedIndex == index
            ? widget.selectedColor
            : widget.unSelectedColor,
        elevation: widget.elevation,
        shape: widget.enableShape
            ? widget.customShape == null
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  )
                : widget.customShape
            : null,
        child: Container(
          height: widget.height,
          width: widget.autoWidth ? null : widget.width,
          constraints: BoxConstraints(maxWidth: 250),
          child: MaterialButton(
            shape: widget.enableShape
                ? widget.customShape == null
                    ? OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor(e), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )
                    : widget.customShape
                : OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor(e), width: 1),
                    borderRadius: BorderRadius.zero,
                  ),
            onPressed: () {
              if (selectedIndex == index) {
                selectedIndex = null;
              } else {
                selectedIndex = index;
              }
              setState(() {});
              widget.checkBoxButtonValues(selectedIndex);
            },
            child: Center(
              child: Text(
                widget.campuses[index].campusID,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: widget.buttonTextStyle.textStyle.copyWith(
                  color: selectedIndex == index
                      ? widget.buttonTextStyle.selectedColor
                      : widget.buttonTextStyle.unSelectedColor,
                ),
              ),
            ),
          ),
        ),
        // ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.absoluteZeroSpacing) {
      widget.spacing = 0;
      widget.padding = 0;
    }
    return _buildCheckBoxButtons();
  }

//
  _buildCheckBoxButtons() {
    if (!widget.horizontal && widget.enableButtonWrap)
      return Container(
        child: Center(
          child: Wrap(
            spacing: widget.spacing,
            direction: Axis.horizontal,
            alignment: widget.wrapAlignment,
            children: _buildButtonsRow(),
          ),
        ),
      );
    if (!widget.horizontal && !widget.enableButtonWrap)
      return Container(
        height: widget.height + widget.padding * 2,
        child: Center(
          child: CustomListViewSpacing(
            spacing: widget.spacing,
            scrollDirection: Axis.horizontal,
            children: _buildButtonsRow(),
          ),
        ),
      );
  }
}
