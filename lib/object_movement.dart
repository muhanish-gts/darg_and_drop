import 'dart:math';

class ObjectMovement {
  final double x0, y0, v_x, v_y, g;

  ObjectMovement(
      {required this.x0,
      required this.y0,
      required this.v_x,
      required this.v_y,
      this.g = 9.8});

  List<Point<double>> calculatePath(
      {double timeStep = 0.1, double maxTime = 10}) {
    List<Point<double>> path = [];
    double t = 0;

    while (t <= maxTime) {
      double x = x0 + v_x * t;
      double y = y0 + v_y * t - 0.5 * g * t * t;
      path.add(Point<double>(x, y));
      t += timeStep;
    }

    return path;
  }
}
