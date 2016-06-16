// This class holds all the data we actually want to draw on the screen.
class Shape {
  Layer parent;

  float x, y;
  float true_x, true_y; // Determines where a Shape is placed within a Layer.

  int vertices = 4; // You can theoretically change this or vary it on an object-to-object basis with no issue.
  float size = shortest_side / 8; // Size of each shape. You can change it to whatever you feel like, or vary on an object-to-object basis.

  PShape data = new PShape();
  PVector zero = new PVector(0, 0);

  Shape(Layer _p) {
    parent = _p;
    
    // We create an "empty" shape. Any shape that has 0 square area shouldn't be drawn.
    data = createShape();
    data.beginShape();
    for (int i = 0; i < vertices; i++) {
      data.vertex(0, 0);
    }
    data.endShape(CLOSE);
  }

  void find_pos() {
    // Randomize the position of our Shape within our Layer parent. The inner and outer bounds are circles.
    float left_bound = -1;
    float right_bound = 1;
    x = random(left_bound, right_bound);
    y = random(left_bound, right_bound);
    if (dist(x, y, 0, 0) < parent.modifier || dist(x, y, 0, 0) > right_bound) {
      find_pos();
    } else {
      // Once a valid position is found, update the position relative to the Layer parent.
      true_x = map(x, left_bound, right_bound, shortest_side / -2, shortest_side / 2);
      true_y = map(y, left_bound, right_bound, shortest_side / -2, shortest_side / 2);
    }
  }

  void set_shape() {
    // Re-calculate the vertices in our Shape.
    // This should only be run when a Layer stops being drawn.
    float angle_increment = TWO_PI / vertices;
    float rotation = atan(true_x / true_y) + QUARTER_PI;
    for (int i = 0; i < vertices; i++) {
      float current_angle = angle_increment * i;
      float vx = size * sin(current_angle + rotation);
      float vy =  size * cos(current_angle + rotation);
      float distance_to_origin = dist(vx + true_x, vy + true_y, 0, 0);
      float distance_mod = pow(map(distance_to_origin, 0, dist(0, 0, width / 2, height / 2), 0, 1), 1);
      data.setVertex(i, vx * distance_mod, vy * distance_mod);
    }
  }

  void reset() {
    // Reset our shape to "empty".
    for (int i = 0; i < vertices; i++) {
      data.setVertex(i, zero);
    }
  }

  void draw() {
    pushMatrix();
    translate(width / 2, height / 2);
    scale(parent.size / max_distance);
    shape(data, true_x, true_y);
    popMatrix();
  }
}