import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:wakely/ui/theme/colors.dart';

class CustomButtonAnimated extends StatefulWidget {
  const CustomButtonAnimated({
    Key? key,
    required this.label,
    required this.onPressed,
    this.iconPaddingLeft = 0,
    this.iconWidth = 100,
    this.iconHeight = 100,
    this.enabled = true,
    this.filled = true,
    this.widthRatio = 0.8,
    this.height = 50,
    this.buttonColor = AppColors.seaFoamGreen,
    this.labelColor = AppColors.floralWhite,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 19,
    // this.postFixIconAsImagePath = null,
    this.fontFamily = "BrandonText",
    this.insets = 8,
  }) : super(key: key);
  final double iconPaddingLeft;
  final double iconWidth;
  final double iconHeight;

  // final String postFixIconAsImagePath;
  final double insets;
  final String label;
  final bool filled;
  final bool enabled;
  final VoidCallback onPressed;
  final double widthRatio;
  final double height;
  final Color buttonColor;
  final Color labelColor;
  final FontWeight fontWeight;
  final double fontSize;
  final String fontFamily;

  @override
  State<CustomButtonAnimated> createState() => _CustomButtonAnimatedState();
}

class _CustomButtonAnimatedState extends State<CustomButtonAnimated> {
  @override
  Widget build(BuildContext context) {
    // _scale = 1 - _controller.value;

    return Padding(
      padding: EdgeInsets.only(top: widget.insets),
      child: AnimatedButton(
        shape: BoxShape.rectangle,
        duration: 90,
        shadowDegree: ShadowDegree.dark,
        onPressed: widget.onPressed,
        enabled: widget.enabled,
        width: MediaQuery.of(context).size.width * widget.widthRatio,
        height: widget.height,
        color: widget.enabled
            ? (widget.filled ? widget.buttonColor : AppColors.floralWhite)
            : Colors.grey.shade300,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontFamily: widget.fontFamily,
                fontWeight: widget.fontWeight,
                fontSize: widget.fontSize,
                // fontStyle: FontStyle.italic,
                color: widget.enabled
                    ? (widget.filled
                        ? widget.labelColor
                        : AppColors.floralWhite)
                    : Colors.grey.shade600,
              ),
            ),
            // if (widget.postFixIconAsImagePath != null)
            //   Padding(
            //     padding: EdgeInsets.only(left: widget.iconPaddingLeft),
            //     child: Image(
            //         image: AssetImage(widget.postFixIconAsImagePath),
            //         width: widget.iconWidth,
            //         height: widget.iconHeight),
            //   ),
          ],
        ),
      ),
    );
  }
}
