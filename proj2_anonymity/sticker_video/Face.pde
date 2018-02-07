class Face {
  Rectangle r; // A Rectangle
  boolean available; // Am I available to be matched?
  boolean delete; // Should I be deleted?  
  int timer = 255; // How long should I live if I have disappeared?
  int id;  // Assign a number to each face

  int imageNum = round(random(0.5, 7.5));
  PImage faceImage = loadImage("data/minguo/" + imageNum +".png");

  // Make me
  Face(int newID, int x, int y, int w, int h) {
    r = new Rectangle(x, y, w, h);
    available = true;
    delete = false;
    id = newID;
  }

  // Show me
  void display() {
    image(faceImage, r.x * scl, r.y * scl, r.width * scl * 1.3, r.height * scl * 1.3);
  }

  // Give me a new location / size
  // Oooh, it would be nice to lerp here!
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
  }

  // Count me down, I am gone
  void countDown() {
    timer = -1;
  }

  // I am deed, delete me
  boolean dead() {
    if (timer < 0) return true;
    return false;
  }
}