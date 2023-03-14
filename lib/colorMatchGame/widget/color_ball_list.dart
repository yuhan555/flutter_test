import 'package:flutter/material.dart';
import 'package:my_test/colorMatchGame/model/color_ball_model.dart';

class ColorBall<T extends Object> extends StatefulWidget {
  final ColorBallModel colorModel;
  final bool drag;
  final Color? data;
  final VoidCallback? onDragCompleted;
  final DraggableCanceledCallback? onDraggableCanceled;
  final DragTargetWillAccept<Color>? onWillAccept;
  final DragTargetAccept<Color>? onAccept;
  final DragTargetLeave<Color>? onLeave;
  final bool disabledDrag;




  const ColorBall({
    Key? key,
    required this.colorModel,
    required this.drag,
    this.data,
    this.onAccept,
    this.onDragCompleted,
    this.onDraggableCanceled,
    this.onLeave,
    this.onWillAccept,
    this.disabledDrag = false,
  }) : super(key: key);

  @override
  State<ColorBall> createState() => _ColorBallState();
}

class _ColorBallState extends State<ColorBall> {
  @override
  Widget build(BuildContext context) {
    if (widget.drag) {
      return Draggable(
        feedback: colorBall(widget.colorModel),
        childWhenDragging: colorBall(widget.colorModel),
        data: widget.data,
        onDragCompleted: widget.onDragCompleted,
        onDraggableCanceled: widget.onDraggableCanceled,
        maxSimultaneousDrags: widget.disabledDrag ? 0 : null, //禁止拖動
        child: colorBall(widget.colorModel),
      );
    } else {
      return DragTarget(
        builder: (context, candidateData, rejectedData) {
          return colorBall(widget.colorModel);
        },
        onWillAccept: widget.onWillAccept,
        onAccept: widget.onAccept,
        onLeave: widget.onLeave,
      );
    }
  }

  Widget colorBall(ColorBallModel model) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: 40,
      height: 40,
      decoration: model.visible
          ? BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: model.color,
          border: model.hover || model.checked ? Border.all(color: Colors.black,width: 2) : null)
          : null,
      child: model.visible ? model.checked ? const Icon(
          Icons.check_circle, color: Colors.black45) : const SizedBox.shrink()
          : null,
    );
  }
}
