// This class holds our Shape objects and will be the primary thing we will be moving.
// To visualize what's happening here, think of a Layer as a circle with a circle contour right in the middle (2D doughnut).
// In any given Layer, the contour is filled with another Layer. 
// When a Layer is too small or its contour is too large to be seen, it is no longer drawn and LinkedList.head updates.
// When a Layers contour is big enough or its size is small enough, a new Layer is drawn inside or around it and LinkedList.head updates.
class Layer {
  Layer next;
  Layer prev; // We're using a doubly linked list since our animation can go in two directions.
  
  float size = MINIMUM_SIZE;
  float modifier = .4; // Determines the size of the contour. In this case, a 100 pixel circle has a 40 pixel contour.
  
  int to_draw = 0;
  
  Shape[] data;
  
  Layer() {
    // Populate our Layer with Shapes.
    data = new Shape[NUMBER_OF_SHAPES];
    for (int i = 0; i < data.length; i++) {
      data[i] = new Shape(this);
    }
    set_shapes();
  }
  
  void set_shapes() {
    // Generates and positions a random number of Shapes.
    clear_shapes();
    to_draw = (int)random(NUMBER_OF_SHAPES);
    for (int i = 0; i < to_draw; i++) {
      data[i].find_pos();
      data[i].set_shape();
    }
  }
  
  void clear_shapes() {
    // Resets all shapes in data.
    for (int i = 0; i < to_draw; i++) {
      data[i].reset();
    }
  }
  
  void draw() {
    for (int i = 0; i < to_draw; i++) {
      data[i].draw();
    }
  }
}