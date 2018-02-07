class Face {
  Rectangle r; // A Rectangle
  boolean available; // Am I available to be matched?
  boolean delete; // Should I be deleted?  
  int timer = 255; // How long should I live if I have disappeared?
  int id;  // Assign a number to each face
  color[] faceColors = {#EF255F, #FCCF4D, #49BEB7, #085F63}; //the color palette for the rectangles
  color faceColor = faceColors[round(random(faceColors.length - 1))];

  // Make me
  Face(int newID, int x, int y, int w, int h) {
    r = new Rectangle(x, y, w, h);
    available = true;
    delete = false;
    id = newID;
  }

  // Show me
  void display() {
    fill(faceColor, timer);
    noStroke();
    rect(r.x, r.y, r.width, r.height);
  }

  // Give me a new location / size
  // Oooh, it would be nice to lerp here!
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
  }

  // Count me down, I am gone
  void countDown() {
    timer -= 10;
  }

  // I am deed, delete me
  boolean dead() {
    if (timer < 0) return true;
    return false;
  }
}