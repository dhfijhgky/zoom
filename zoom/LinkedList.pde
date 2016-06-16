// This class holds all of Layers in a fixed order, but lets us change the start easily.
class LinkedList {
  Layer head = null;
  
  int size = 0;
  int to_draw = 10;
  
  Iterator draw_iter = new Iterator(this); // This iterator will help us draw the Layers we want to display.
  
  void push(Layer l) {
    // Add Layers to the LinkedList.
    // This should only be run NUMBER_OF_LAYERS times in setup().
    if (head == null) {
      head = l;
      head.prev = head.next = l;
    }
    
    l.prev = head.prev;
    l.next = head;
    head.prev.next = head.prev = l;
    size++;
  }
  
  void next() {
    head = head.next;
  }
  
  void prev() {
    head = head.prev;
  }
  
  void draw() {
    if (head != null) {
      manager.draw();
      
      // We draw our Layers in reverse order in case of clipping issues (though this should never happen).
      draw_iter.set_pos(to_draw);
      for (int i = 0; i < to_draw; i++) {
        draw_iter.data.draw();
        draw_iter.prev();
      }
    }
  }
}