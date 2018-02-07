// Design Concept
// A hot pot of steaming noodles, with some moving outlines.

// Displaying Setting
// The animation would be placed in a modern fusion food restaurant.
// It can be an element in the enviroment (projected onto the wall), or as an advertisement.

float rotationAmount = 0;
float theta = 0;
float angle = 0;
float oil_X = 0;
float oil_Y = 0;
float oil_Size = 0;

void setup() { 
  size(800, 800);
  background(#FFF4CE);
  ellipseMode(RADIUS);
  rectMode(CENTER);
  colorMode(HSB, 100);
}

void draw() {
  rotationAmount = rotationAmount + 1;
  
  //bgd
  background(#FFF4CE);
  
  theta += 0.03;
  strokeWeight(2);
  float[] line = {250, 400, 550};
  for (float i : line) {
    if (i % 100 == 50){
      float x = (sin(theta) + 1) * width/2; 
      line(x - i/2, i, x + i/2, i);
    } else {
      float x = (- sin(theta) + 1) * width/2;
      line(x - i/2, i, x + i/2, i);
    }
  }
  
  //plate-fill
  noStroke();
  fill(#FFF4CE);
  ellipse(width/2, height/2, 220, 220);
  fill(#FFC8A5);
  ellipse(width/2, height/2, 180, 180);

  //shrimp-fill
  noFill();
  stroke(#FFF2EA);
  strokeWeight(18);
  arc(320, 370, 20, 43, 0, 3*QUARTER_PI);
  arc(480, 480, 30, 20, QUARTER_PI, 7*QUARTER_PI);
  
  //tofu-fill
  fill(#835C66);
  noStroke();
  triangle(499, 289, 469, 347, 540, 360);
  triangle(471, 302, 452, 374, 509, 371);
  
  //vege-fill
  fill(#419836);
  triangle(360, 451, 346, 479, 379, 462);
  quad(345, 466, 321, 472, 366, 502, 371, 484);
  
  triangle(399, 495, 372, 514, 383, 483);
  quad(357, 509, 352, 530, 404, 536, 403, 518);
  
  quad(351, 503, 341, 518, 310, 501, 323, 483);
  quad(400, 506, 410, 523, 441, 515, 438, 502);
  
  //noodles-fill
  noFill();
  stroke(#FFF9E0);
  strokeWeight(20);
  bezier(451, 477, 235, 427, 508, 286, 292, 283);
  bezier(463, 390, 378, 456, 569, 367, 507, 448);
  
  //oil
  //cannot move now
  noStroke();
  fill(#fd7f40);
  
  int[] oil = { 3, 5, 8 };
  for (int i : oil) {
    pushMatrix();
    translate(400, 400);
    oil_X = 30 * sqrt(i) - 28;
    oil_Y = - sqrt(sq(160) - sq(oil_X));
    oil_Size = i;
    ellipse(oil_X, oil_Y, oil_Size, oil_Size);
    popMatrix();
  }

  ellipse(296, 522, 4, 4);
  noFill();
  stroke(#fd7f40);
  strokeWeight(8);
  arc(width/2, height/2, 160, 160, 3*QUARTER_PI, PI);
  
  //setup for contour
  noFill();
  stroke(0);
  strokeWeight(2);
  strokeCap(ROUND);
  
  //plate-contour
  pushMatrix();
  rotate(radians(116));
  translate(169, -528);
  float x2 = (sin(2 * theta) + 1) * width/2;   
  line(- x2 / 4, 0, x2 / 20, 0);
  popMatrix();
  
  pushMatrix();
  rotate(radians(87));
  translate(402, -380);
  float x3 = (sin(2.5 * theta) + 1) * width/2;   
  line(- x3 / 4, 0, x3 / 4, 0);
  popMatrix();
  
  int[] radius = { 200, 175, 190 };
  for (int i : radius) {
    pushMatrix();
    translate(400, 400);
    angle = (i % 30) / 20 * PI;
    rotate(rotationAmount * sq(9000/sq(i)));
    arc(0, 0, i, i, angle/6, angle/2 + HALF_PI);
    popMatrix();
  }
  
  //shrimp1-contour
  arc(320, 370, 30, 50, 0, 3*QUARTER_PI);
  arc(320, 360, 20, 40, 0, 3*QUARTER_PI);
  line(306, 390, 301, 410);
  line(321, 399, 322, 419);
  line(333, 388, 342, 403);
  line(338, 378, 350, 380);

  //shrimp2-contour
  arc(480, 480, 36, 26, QUARTER_PI, 7*QUARTER_PI);
  arc(480, 480, 14, 10, QUARTER_PI, 7*QUARTER_PI);
  line(503, 459, 490, 469);
  line(474, 453, 473, 468);
  line(447, 467, 465, 476);
  line(452, 497, 468, 486);
  line(487, 502, 484, 493);
  //tail
  line(504, 498, 521, 497);
  line(500, 496, 515, 490);
  line(497, 491, 510, 486);
  line(493, 486, 512, 476);
  
  //tofu-contour
  triangle(500, 300, 474, 352, 533, 362);
  triangle(477, 311, 461, 366, 516, 368);

  //veg
  triangle(365, 451, 346, 479, 379, 462);
  beginShape();
  vertex(345, 468);
  vertex(327, 468);
  vertex(337, 475);
  vertex(332, 488);
  vertex(346, 485);
  vertex(347, 497);
  vertex(357, 485);
  vertex(366, 498);
  vertex(369, 484);
  endShape();
  
  triangle(399, 495, 375, 515, 387, 485);
  beginShape();
  vertex(364, 513);
  vertex(359, 529);
  vertex(372, 521);
  vertex(376, 532);
  vertex(382, 523);
  vertex(397, 530);
  vertex(392, 518);
  endShape();
  
  beginShape();
  vertex(364, 513);
  vertex(359, 529);
  vertex(372, 521);
  vertex(376, 532);
  vertex(382, 523);
  vertex(397, 530);
  vertex(392, 518);
  endShape();
  
  beginShape();
  vertex(345, 503);
  vertex(332, 508);
  vertex(333, 494);
  vertex(316, 501);
  vertex(320, 485);
  endShape();
  
  beginShape();
  vertex(409, 509);
  vertex(416, 519);
  vertex(418, 509);
  vertex(435, 512);
  vertex(433, 501);
  endShape();
  
  //noodles
  bezier(428, 473, 252, 427, 498, 288, 284, 283);
  bezier(434, 466, 255, 423, 518, 290, 290, 275);
  bezier(355, 446, 320, 401, 428, 288, 309, 298);
  
  bezier(466, 385, 385, 456, 569, 369, 509, 446);
  bezier(471, 389, 412, 437, 573, 366, 520, 441);
  bezier(438, 397, 394, 475, 569, 378, 495, 449);
  
}

void keyPressed(){
  saveFrame("week2####.png");
}

  