// Oliver Leighton
// Processing 3 (revision 0247).
// This is the final code from my senior project (with some added comments).
// Feel free to use this code however you please, just let me know at oleighton@ucla.edu.

// The point of this project was not to make a statement, but to attempt to create a sense of 3D movement.
// Hopefully, it looks as though you are entering or leaving a tunnel that lasts forever.
// As an installation, this is accompanied with a custom controller and is projected onto the ground (smooth concrete).
// People either walked over it or stared at it for a decent amount of time.
// It seemed to be a hit with the kids.

// If you want to change stuff, I would start with NUMBER_OF_LAYERS, NUMBER_OF_SHAPES, and Manager functions (especially move()).
// If you want to get more complicated, start messing with the Shape class.
// The Iterator, Layer, and LinkedList classes are all pretty boring, but feel free to change them if you've got a rad idea.

import processing.serial.*;

Serial port;
LinkedList data;
Manager manager;

final int FPS = 120;
final int NUMBER_OF_LAYERS = 12;
final int NUMBER_OF_SHAPES = 30;

final float MINIMUM_SIZE = .5; // Size that a Layer is too small to be seen.

float max_distance, shortest_side;

int time, last_freeze = 0; // Debugging variables.

void setup() {
  // Sets up framerate, size, and color settings.
  frameRate(FPS);
  //size(500, 500);
  fullScreen();
  noCursor();
  noStroke();
  fill(255);
  
  // Initializes max_distance (pixels from one corner to opposite corner) and shortest_side (either width or height).
  max_distance = sqrt(pow(width, 2) + pow(height, 2));
  shortest_side = width < height ? width : height;
  
  // Instantiates a Manager, Serial, and LinkedList.
  port = new Serial(this, Serial.list()[3], 6557);
  println(Serial.list()[3]);
  data = new LinkedList();
  manager = new Manager(data);
  
  // Populates new LinkedList (data).
  for (int i = 0; i < NUMBER_OF_LAYERS; i++) {
    Layer l = new Layer();
    data.push(l);
  }
}

void draw() {
  // DEBUGGING
  /*if (millis() - time > 1000.0 / (FPS / 8)) {
    println("froze at " + millis() + " for " + (millis() - time) + ". last freeze was " + (millis() - last_freeze) + " ago.");
    last_freeze = millis();
  }
  time = millis();*/
  // DEBUGGING
  
  background(0);
  data.draw();
}


// ---- ARDUINO CODE ---- 
// This reads analog voltage from a potentiometer and gives us a number between 0 and 1023.
// Manager.move() will read the jumbled string the Arduino sends and convert it into a usable number.

/*
void setup() {
  Serial.begin(6557);
}

int val = 0;
String mod = "";
int prev_val = 0;

void loop() {
  val = analogRead(0);
  if (val != prev_val) {
    if (val < 1000) {
      if (val < 100) {
        if (val < 10) {
          mod += "0";
        }
        mod += "0";
      }
      mod += "0";
    }
    Serial.println(mod + val);
    mod = "";
  }
  prev_val = val;
}
*/ 

// ---- ---- ---- ---- ----