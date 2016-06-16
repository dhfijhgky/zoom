// This class gives us an easy way to search through our LinkedList.
class Iterator {
  LinkedList parent;
  Layer data;
  
  int position = 0;
  
  Iterator(LinkedList _p) {
    parent = _p;
    data = parent.head;
  }
  
  void refresh() {
    data = parent.head;
    position = 0;
  }
  
  void next() {
    data = data.next;
    position++;
  }
  
  void prev() {
    data = data.prev;
    position--;
  }
  
  void set_pos(int pos) {
    refresh();
    for (int i = 0; i < pos; i++) {
      next();
    }
  }
}