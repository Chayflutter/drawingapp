import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:myapp/components/floatingbutton.dart';
import 'package:myapp/modal/drawingpainter.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

@override
  _DrawingPageState createState() => _DrawingPageState();
}




class _DrawingPageState extends State<DrawingPage> {
  List<DrawingPoints> points = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 2.0;
  List<Color> colorOptions = [
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.brown,
  ];
  


void pickColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              availableColors: colorOptions, // Use custom color list here
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

void changeColor(Color color) {
    Navigator.of(context).pop(); // Close the dialog
    setState(() {
      selectedColor = color;
    });
  }

Widget _buildFab(BuildContext context) {
  final icons = [ Icons.edit, Icons.mail, Icons.phone ];
  return FabWithIcons(
    icons: icons,
    onIconTapped: (index) {
      print(index);
    if(index == 0){
      pickColor();
    }
    },
  );
}
// pickColor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draw on Canvas"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => setState(() => points.clear()),
          ),
        ],
      ),
       floatingActionButton: _buildFab(context),
      body: GestureDetector(
        onPanUpdate: (details) {
          RenderBox? renderBox = context.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            setState(() {
              points.add(
                DrawingPoints(
                  points: renderBox.globalToLocal(details.localPosition),
                  paint: Paint()
                    ..strokeCap = StrokeCap.round
                    ..isAntiAlias = true
                    ..color = selectedColor
                    ..strokeWidth = strokeWidth,
                  isPoint: true,
                ),
              );
            });
          }
        },
        onPanEnd: (details) {
          setState(() {
            points.add(DrawingPoints(
                points: Offset.zero, paint: Paint(), isPoint: false));
          });
        },
        child: CustomPaint(
          painter: DrawingPainter(points: points),
          child: Container(),
        ),
      ),
    );
  }
  }