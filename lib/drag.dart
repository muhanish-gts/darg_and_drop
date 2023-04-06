import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DragAndDrop extends StatefulWidget {
  const DragAndDrop({super.key});

  @override
  State<DragAndDrop> createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  bool isDropped = false;
  double width = 100;
  double height = 100;
  double ballRadius = 50;

  final String _color = "red";

  Offset? position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    position = const Offset(0.0, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = width * 9 / 16;
    return Scaffold(body: withPan(width, height));
  }

  Widget withPan(double width, double height) {
    return GestureDetector(
      onPanStart: (details) => _onPanStart(context, details),
      onPanUpdate: (details) => _onPanUpdate(context, details, position!),
      onPanEnd: (details) => _onPanEnd(context, details),
      onPanCancel: () => _onPanCancel(context),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: position!.dy - ballRadius - 15,
                left: position!.dx,
                child: Text('${position!.dx}, ${position!.dy}')),
            Positioned(
              top: position!.dy - ballRadius,
              left: position!.dx,
              child: ball(ballRadius, Offset(position!.dx, position!.dy)),
            ),
          ],
        ),
      ),
    );
  }

  void _onPanStart(BuildContext context, DragStartDetails details) {
    print(
        "${details.globalPosition.dx.floorToDouble()}, ${details.globalPosition.dy.floorToDouble()}");
  }

  void _onPanUpdate(
      BuildContext context, DragUpdateDetails details, Offset offset) {
    // center (x,y)
    double ballX = double.parse(
        (details.globalPosition.dx - ballRadius).toStringAsPrecision(4));
    double ballY = double.parse(
        (details.globalPosition.dy - ballRadius).toStringAsPrecision(4));
    print("center ($ballX, $ballY)");
    setState(() {
      position = Offset(ballX, ballY);
    });
  }

  void _onPanEnd(BuildContext context, DragEndDetails details) {
    print(details.velocity);
    print(details.velocity.pixelsPerSecond);
  }

  void _onPanCancel(BuildContext context) {
    print("Pan canceled !!");
  }

  Widget withDragable() {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: position!.dx,
              top: position!.dy,
              child: Draggable(
                feedback: Container(
                  color: Colors.red[800],
                  width: width,
                  height: height,
                  child: Center(
                    child: Text(
                      "Drag",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                onDraggableCanceled: (Velocity velocity, Offset offset) {
                  setState(() => position = offset);
                },
                child: Container(
                  width: width,
                  height: height,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      "Drag",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget ball(double radius, Offset offset) {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1,
      dashPattern: const [
        5,
        5,
      ],
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(radius),
        ),
        // child: const Center(
        //   child: Text(
        //     'dc',
        //     style: TextStyle(color: Colors.black),
        //   ),
        // ),
      ),
    );
  }

  Widget sta() {
    return Stack(
      children: [
        Positioned(
          top: 100,
          left: 100,
          child: LongPressDraggable<String>(
            // Data is the value this Draggable stores.
            data: _color,
            feedback: Material(
              child: Container(
                height: 170.0,
                width: 170.0,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                ),
                child: const Center(
                  child: Text(
                    'Dragging',
                    textScaleFactor: 2,
                  ),
                ),
              ),
            ),
            childWhenDragging: Container(
              height: 150.0,
              width: 150.0,
              color: Colors.grey,
              child: const Center(
                child: Text(
                  'I was here',
                  textScaleFactor: 2,
                ),
              ),
            ),
            child: Container(
              height: 150.0,
              width: 150.0,
              color: Colors.redAccent,
              child: const Center(
                child: Text(
                  'Drag me',
                  textScaleFactor: 2,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(6),
              color: Colors.black,
              strokeWidth: 2,
              dashPattern: const [8],
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 200,
                  width: 200,
                  color: isDropped ? Colors.redAccent : null,
                  child: Center(
                      child: Text(
                    !isDropped ? 'Drop here' : 'Dropped',
                    textScaleFactor: 2,
                  )),
                ),
              ),
            );
          },
          onAccept: (data) {
            debugPrint('hi $data');
            setState(() {
              isDropped = true;
            });
            debugPrint('hi $isDropped');
          },
          onWillAccept: (data) {
            return data == _color;
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem(Color color) {
    return LongPressDraggable(
      // data: item,
      // dragAnchorStrategy: pointerDragAnchorStrategy,
      // feedback: DraggingListItem(
      //   dragKey: _draggableKey,
      //   photoProvider: item.imageProvider,
      // ),
      // child: MenuListItem(
      //   name: item.name,
      //   price: item.formattedTotalItemPrice,
      //   photoProvider: item.imageProvider,
      // ),

      feedback: Container(
        width: 110,
        height: 60,
        color: color,
      ),
      child: Container(
        width: 100,
        height: 50,
        color: color,
      ),
    );
  }
}
