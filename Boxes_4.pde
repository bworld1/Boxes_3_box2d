// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

//
ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;
Boundary bn;

Box2DProcessing box2d;    

void setup() {
  size(1024, 1024);
  // Initialize and create the Box2D world
  box2d = new Box2DProcessing(this);  
  box2d.createWorld();
  box2d.setGravity(0, -10);

  // Create ArrayLists
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();

  addBoundaries();
}

void addBoundaries() {
  for (int i = 0; i < 9; i++) {
    float x1 = random(200, width-200);
    float y1 = random(200, height-200);
    float ang = random(2 * PI);
    float inang = (PI/2) - ang;

    float bwth = random(5, 200), blth = random(5, 200);
    float ca = cos(ang), sa = sin(ang), caa = cos(inang), saa = sin(inang);
    float x2, y2, x3, y3, x4, y4;
    x2 = x1-bwth*ca;
    y2 = y1-bwth*sa;
    x4 = x1+blth*caa;
    y4 = y1-blth*saa;
    x3 = x4-(bwth*ca);
    y3 = y4-(bwth*sa);

    //Add boundaries
    boundaries.add(new Boundary(x1, y1, x2, y2, x3, y3, x4, y4));
  }
}

void draw() {
  background(0);

  // We must always step through time!
  box2d.step();

  // When the mouse is clicked, reset all.
  if (mousePressed) {
    for (int i = boxes.size()-1; i >= 0; i--) {
      Box b = boxes.get(i);
      b.killBody();
      boxes.remove(i);
    }
    for (int i = boundaries.size()-1; i >= 0; i--) {
      Boundary bn = boundaries.get(i);
      bn.killPoly();
      boundaries.remove(i);  
    }
    
    addBoundaries();
  }
  
  Box p = new Box(width/2, 10, int(random(10, 255)), int(random(10, 255)), int(random(10, 255)));
  boxes.add(p);

  //display the boundaries
  for (Boundary wall : boundaries) {
    wall.display();
  }

  // Display all the boxes
  for (Box b : boxes) {
    b.display();
  }

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
}