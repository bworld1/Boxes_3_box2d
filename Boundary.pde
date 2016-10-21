// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A fixed boundary class

class Boundary {
  float x1, y1, x2, y2, x3, y3, x4, y4;

  Body poly;

  Boundary(float x1_, float y1_, float x2_, float y2_, float x3_, float y3_, float x4_, float y4_) {
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;
    x3 = x3_;
    y3 = y3_;
    x4 = x4_;
    y4 = y4_;

    float sx1 = box2d.scalarPixelsToWorld(x1);    
    float sy1 = box2d.scalarPixelsToWorld(-y1);
    float sx2 = box2d.scalarPixelsToWorld(x2);
    float sy2 = box2d.scalarPixelsToWorld(-y2);
    float sx3 = box2d.scalarPixelsToWorld(x3);
    float sy3 = box2d.scalarPixelsToWorld(-y3);
    float sx4 = box2d.scalarPixelsToWorld(x4);
    float sy4 = box2d.scalarPixelsToWorld(-y4);

    Vec2[] vertices = {
      new Vec2(sx1, sy1), 
      new Vec2(sx2, sy2), 
      new Vec2(sx3, sy3), 
      new Vec2(sx4, sy4), 
    };

    PolygonShape ps = new PolygonShape();
    ps.set(vertices, vertices.length);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x1/6, y1/6));
    poly = box2d.createBody(bd);

    // Define a fixture
    FixtureDef sd = new FixtureDef();
    sd.shape = ps;
    poly.createFixture(sd);
  }
  
  void killPoly() {
    box2d.destroyBody(poly);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(poly);
    PShape sh;
    fill(220, 10, 0);
    pushMatrix();
    translate(pos.x, pos.y);
    sh = createShape();
    sh.beginShape();
    sh.vertex(x1, y1);
    sh.vertex(x4, y4);
    sh.vertex(x3, y3);
    sh.vertex(x2, y2);
    sh.endShape(CLOSE);

    //fill(220, 10, 0);
    stroke(0);
    shape(sh, 0, 0);
    popMatrix();
  }
}