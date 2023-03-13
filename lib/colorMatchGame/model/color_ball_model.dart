import 'dart:ui';

class ColorBallModel{
  Color color;
  bool hover;
  bool checked;
  bool visible;


  ColorBallModel({
    required this.color,
    this.hover = false,
    this.checked = false,
    this.visible = true,
  });

  ColorBallModel copyWith(){
    return ColorBallModel(
      color: color,
      hover: hover,
      checked: checked,
      visible: visible,
    );
  }
}