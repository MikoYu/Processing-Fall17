//references
//https://www.openprocessing.org/sketch/396718

//relative values of current mouse location; angle & distance to the center
float ctrX, ctrY, ctrRtt, ctrAng, ctrDist;
//values above, but for previous frame
float pCtrX, pCtrY, pCtrRtt, pCtrAng, pCtrDist;

//parameters for stroke size
float sizeRt = 0.5;
float strokeRRate, strokeR;
//frame rate
float frmRt = 120;

void setup() {
  background(0);
  size(200, 200);

  noStroke();

  frameRate(frmRt);
  smooth();
}

void draw() {
  //set rotation
  ctrRtt = 0;
  pCtrRtt = 0;
  
  //map X & Y to value between -1 and 1
  ctrX = map(mouseX, 0, width, -1, 1);
  ctrY = map(mouseY, height, 0, -1, 1);
  pCtrX = map(pmouseX, 0, width, -1, 1);
  pCtrY = map(pmouseY, height, 0, -1, 1);
  
  //caculate distance and angle (to the center of the canvas)
  ctrDist = sqrt(sq(ctrX) + sq(ctrY));
  ctrAng = atan2(ctrY, ctrX) ;
  pCtrDist = sqrt(sq(pCtrX) + sq(pCtrY));
  pCtrAng = atan2(pCtrY, pCtrX);
  
  //caculate stroke weight (size of the hexagon) 
  strokeRRate = frmRt * sq(sq(ctrDist) - sq(pCtrDist));
  strokeR = sizeRt * sq(2 / ( 1 + strokeRRate));
}

//to draw a single hexagon
void drawHex(float x, float y, float r) {
  pushMatrix();
  translate(x, y);
  for (int i = 0; i < 6; i ++) {
    rotate(PI / 3);
    triangle(0, 0, 0, r, r * sqrt(3) / 2, r /2);
  }  
  popMatrix();
}

//draw 12 symmetrical haxagons when mouse being dragged
void mouseDragged() {
  while (ctrRtt < TWO_PI) {
    float x1 = ctrDist * cos(ctrAng + ctrRtt);
    float y1 = ctrDist * sin(ctrAng + ctrRtt);
    float x2 = ctrDist * cos(- ctrAng + ctrRtt);
    float y2 = ctrDist * sin(- ctrAng + ctrRtt);

    float snowX1 = map(x1, -1, 1, 0, width);
    float snowY1 = map(y1, -1, 1, height, 0);
    float snowX2 = map(x2, -1, 1, 0, width);
    float snowY2 = map(y2, -1, 1, height, 0);

    //hexagon
    float snowAlpha = map(strokeR, 100, 80, 0, 6);
    fill(255, snowAlpha);
    drawHex(snowX1, snowY1, strokeR);
    drawHex(snowX2, snowY2, strokeR);

    ctrRtt = ctrRtt + TWO_PI/6;
    pCtrRtt = pCtrRtt + TWO_PI/6;
  }
}

//press 'space' to refresh
//press 's' to save
void keyPressed() {
  if (key == ' ') {
    setup();
  }
  if (key == 's') {
    saveFrame(dataPath("snow#####.png"));
  }
}