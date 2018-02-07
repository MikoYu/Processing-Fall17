float[] flyingXPositions;
float[] flyingYPositions;
float[] flyingXSpeeds;
float[] flyingYSpeeds;
float[] flyingYSpeedThetas;
float[] flyingYSpeedAs;
float[] flyingRotations;
float[] flyingScales;
int numFlyingFlowers = 15;
//boolean blow = false;

void setup() {
  size(800, 450);

  flyingXPositions = new float[numFlyingFlowers];
  flyingYPositions = new float[numFlyingFlowers];
  flyingXSpeeds = new float[numFlyingFlowers];
  flyingYSpeeds = new float[numFlyingFlowers];
  flyingYSpeedThetas = new float[numFlyingFlowers];
  flyingYSpeedAs = new float[numFlyingFlowers];
  flyingRotations = new float[numFlyingFlowers];
  flyingScales = new float[numFlyingFlowers];

  for (int i = 0; i < numFlyingFlowers; i++) {
    flyingXPositions[i] =random(0, 200);
    flyingYPositions[i] =250;
    flyingXSpeeds[i] = random(3, 8);
    flyingYSpeeds[i] = random(8, 12);
    flyingYSpeedThetas[i] = random(- PI/4, PI/4);
    flyingYSpeedAs[i] = random(1, 2);
    flyingRotations[i] = random(- PI, PI);
    flyingScales[i] = random(0.5, 1);
  }
}

void draw () {
  background(0);

  //flyingFlowers, i.e. particles
  noFill();
  strokeWeight(2);

  for (int i = 0; i < numFlyingFlowers; i++) {

    flyingXPositions[i] = flyingXPositions[i] + flyingXSpeeds[i];
    flyingYSpeedThetas[i] = flyingYSpeedThetas[i] + PI/30;
    flyingYSpeeds[i] = flyingYSpeedAs[i] * (- 1 - sin(flyingYSpeedThetas[i]));
    flyingYPositions[i] = flyingYPositions[i] + flyingYSpeeds[i];

    //if (flyingXPositions[i] > 850) {
    //  flyingXPositions[i] = random(0, 200);
    //  stroke(0, 90);
    //  flyingYPositions[i] = 250;
    //} else if (flyingXPositions[i] > 200) {
    //  stroke(255, 90);
    //} else {
    //  stroke(0, 90);
    //  flyingYPositions[i] = 250;
    //}

    if (flyingXPositions[i] > 850) {
      flyingXPositions[i] = random(0, 200);
      stroke(0, 90);
      flyingYPositions[i] = 250;
    } else if (flyingXPositions[i] > 200) {
      stroke(255, 90);
    } else {
      stroke(0, 90);
      flyingYPositions[i] = 250;
    }

    pushMatrix();    
    translate(flyingXPositions[i], flyingYPositions[i]);
    rotate(flyingRotations[i]);
    scale(flyingScales[i]);
    curve(30, 47, - 2, -10, - 4, - 45, 7, -50);
    pushMatrix();
    translate(-4, -45);
    for (int j = 0; j < 5; j ++) {
      float petalRotation = 15 * j;
      rotate(radians(petalRotation));
      line(-1, -1, -4, -4);
    }
    popMatrix();
    popMatrix();
  }


  //static
  float[] dandelionSize = {100, 200};
  for (float s : dandelionSize) {

    pushMatrix();
    translate(s, 450 - s);

    //stem
    stroke(255, 50);
    strokeWeight(4);
    noFill();
    bezier(0, 10, 29, 108, -20, 75, 15, 200);

    //center
    fill(255, 50);
    stroke(255, 50);
    strokeWeight(1);
    randomSeed(0);
    for (int i = 0; i < s * 4; i++) {
      float ctrSize = random(0, 1);
      float ctrXPosition = random(-10, 10);
      float ctrYPosition = random (- sqrt(100 - sq(ctrXPosition)), sqrt(100 - sq(ctrXPosition)));
      ellipse(ctrXPosition, ctrYPosition, ctrSize, ctrSize);
    }

    popMatrix();

    //flowers
    noFill();
    stroke(255, 90);
    strokeWeight(2);

    pushMatrix();
    translate(s, 450 - s);
    scale(s/200);

    for (int i = 0; i < s/4; i ++) {
      float flowerRotation = random(16, 24);
      rotate(radians(flowerRotation));
      float flowerScale = random(1, 1.1);

      pushMatrix();    
      scale(flowerScale);
      curve(30, 47, - 2, -10, - 4, - 45, 7, -50);
      pushMatrix();
      translate(-4, -45);
      for (int j = 0; j < 5; j ++) {
        float petalRotation = 15 * j;
        rotate(radians(petalRotation));
        line(-1, -1, -4, -4);
      }
      popMatrix();
      popMatrix();
    }

    for (int i = 0; i < s/8; i ++) {
      float flowerRotation = random(15, 45);
      rotate(radians(flowerRotation));
      float flowerScale = random(0.5, 0.9);

      pushMatrix();    
      scale(flowerScale);
      curve(30, 47, - 2, -10, - 4, - 45, 7, -50);
      pushMatrix();
      translate(-4, -45);
      for (int j = 0; j < 5; j ++) {
        float petalRotation = 15 * j;
        rotate(radians(petalRotation));
        line(-1, -1, -4, -4);
      }
      popMatrix();
      popMatrix();
    }
    popMatrix();
  }
  
  //blow = false;
}

void mouseMoved () {
  //blow = true;
}

void keyPressed () {
  saveFrame("week7####.png");
}