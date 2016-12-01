// This class manages all of the Layer movement.
class Manager {
  LinkedList parent;
  
  // move_speed is the variable we will manipulate directly, move is simply tied to it.
  float move_speed = 1;
  float move = 0;
  
  // These floats are used to calibrate the range of the controller.
  // Sometimes moving the lever wouldn't move the potentiometer, so this was my solution to keep the movement constant.
  float lower_bound = pow(2, 0) - 1;
  float higher_bound = pow(2, 10) - 1;
  
  // port_string and port_value are to hold the data the Arduino sends to us.
  String port_string;
  int port_value = 512;
  
  Iterator iter;
  
  Manager(LinkedList _p) {
    parent = _p;
    iter = new Iterator(parent);
    set_move();
  }
  
  void update_size() {
    // This function first checks if all Layers currently being drawn should actually be drawn, and corrects if this isn't the case.
    // Then, it modifies the size of each Layer being drawn by move.
    iter.refresh();
    if (move < 1) {
      // If we're moving inwards:
      while (iter.data.size < MINIMUM_SIZE) {
        iter.data.set_shapes();
        parent.next();
        iter.refresh();
      }
    } else {
      // If we're moving outwards:
      while (iter.data.size * iter.data.modifier > MINIMUM_SIZE) {
        parent.prev();
        iter.refresh();
        iter.data.size = iter.data.next.size * iter.data.next.modifier;
        iter.data.set_shapes();
      }
    }
    // Modify Layer sizes.
    iter.data.size *= move;
    for (int i = 0; i < parent.to_draw; i++) {
      iter.data.next.size = iter.data.size / iter.data.modifier;
      iter.next();
    }
  }
  
  void move() {
    // The top half of this code works with a potentiometer attached to an Arduino.
    // The up and down arrow keys work to calibrate the range of motion.
    // You would push up at the top-most controller position, and down at the bottom.
    // The second half works with a keyboard. Left and right arrow keys control the speed, spacebar pauses it.
    
    // ---- FOR USE WITH ARDUINO BASED CONTROLLER ----
    // If you uncomment this, you will also need to uncomment lines 47-48 in zoom.pde.
    /*
    if (port.available() > 0) {
      port_string = port.readString();
      if (port_string.length() >= 6) {
        port_string = port_string.substring(port_string.length() - 6);
        port_value = Integer.parseInt(trim(port_string));
        println(port_value);
        float middle = (lower_bound + higher_bound) / 2;
        move_speed = pow(map(abs(port_value - middle), 0, pow(2, 9), 0, 3), 1.5);
        if (port_value < middle) {
          move_speed *= -1;
        }
        set_move();
      }
    }
    if (keyPressed) {
      if (keyCode == 38) {
        lower_bound = port_value;
      }
      if (keyCode == 40) {
        higher_bound = port_value;
      }
    }
    */
    // ---- ---- ---- ---- ----
    
    
    
    // ---- FOR USE WITH KEYBOARD ----
    if (keyPressed) {
      if (keyCode == 37) {
        move_speed += .01;
      } else if (keyCode == 39) {
        move_speed -= .01;
      } else if (key == ' ') {
        move_speed = 0;
      }
      set_move();
    }
    // ---- ---- ---- ---- ----
  }
  
  void set_move() {
    // Update move with our calculations. Should be run every time input is read.
    move = 1 - (move_speed / FPS);
  }
  
  void draw() {
    move();
    update_size();
  }
}
