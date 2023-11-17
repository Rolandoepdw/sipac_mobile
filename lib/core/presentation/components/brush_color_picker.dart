import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';

class BrushColorPicker extends StatefulWidget {
  final Color? color;
  final Function callBack;

  const BrushColorPicker(this.color, this.callBack, {Key? key}) : super(key: key);

  @override
  State<BrushColorPicker> createState() => _BrushColorPickerState(color);
}

class _BrushColorPickerState extends State<BrushColorPicker> {
  late Color? color;

  _BrushColorPickerState(this.color){
    color = color ?? primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: ShapeDecoration(color: color, shape: const CircleBorder()),
      child: IconButton(
          icon: const Icon(Icons.palette_rounded),
          iconSize: 28,
          onPressed: () async {
            // Store current color before we open the dialog.
            final Color colorBeforeDialog = color!;
            // Wait for the picker to close, if dialog was dismissed,
            // then restore the color we had before it was opened.
            if (!(await colorPickerDialog())) {
              setState(() {
                color = colorBeforeDialog;
                widget.callBack(color);
              });
            }
          }),
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: color!,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) => setState(() {
        this.color = color;
        widget.callBack(color);
      }),
      width: 40,
      height: 40,
      borderRadius: 50,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(context,
        // New in version 3.0.0 custom transitions support.
        transitionBuilder: (BuildContext context, Animation<double> a1,
            Animation<double> a2, Widget widget) {
      final double curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
        child: Opacity(
          opacity: a1.value,
          child: widget,
        ),
      );
    },
        transitionDuration: duration500,
        constraints:
            const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
        barrierColor: Colors.black.withOpacity(0.5),
        useSafeArea: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(highRadius),
        ));
  }

  // Define custom colors. The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };
}
