import 'package:flutter/material.dart';

class DragAndDrop extends StatelessWidget {
  const DragAndDrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(Colors.redAccent),
                  _buildMenuItem(Colors.amberAccent),
                  _buildMenuItem(Colors.greenAccent),
                ],
              )
            ],
          ),
        ),
      ),
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
