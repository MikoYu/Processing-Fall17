//future iteration
//snowflake positions and movements in 3D

//references
//gradient choices from https://webgradients.com/
////010 Winter Neva: #a1c4fd→#c2e9fb
////050 sf Again: #e6e9f0→#eef1f5
////051 February Ink: #accbee→#e7f0fd

//arrays of snowflake parameters
float[] sfXPositions;
float[] sfXSpeeds;
float[] sfYPositions;
float[] sfYSpeeds;
float[] sfSizes;
//number of snowflakes being shown
int numSfs = 40;

//background gradient colors
color c1, c2;

//to read and load snowflake image files
import java.io.File;
//import java.io.FilenameFilter;
File folder;
PImage[] snowflakes;

String path;
ArrayList<String> files;

void setup () {

  files = new ArrayList<String>();
  size(800, 800);  
  fill(255);
  noStroke();
  blendMode(ADD);

  // Define colors
  c1 = color(194, 233, 251);
  c2 = color(161, 196, 253);

  //read image file names
  path = sketchPath("snowflake/data");
  listFileNames(path);

  //load images
  snowflakes = new PImage[numSfs];
  for (int i = numSfs - 1; i >= 0; i--) {
    int j = i % files.size();
    println(j);
    snowflakes[i] = loadImage("snowflake/data/" + files.get(j), "png");
    println("snowflake/data/" + files.get(j));
  }

  //set initial values for snowflake parameters
  sfXPositions = new float[numSfs];
  sfYPositions = new float[numSfs];
  sfYSpeeds = new float[numSfs];
  sfXSpeeds = new float[numSfs];
  sfSizes = new float[numSfs];
  for (int i = 0; i < numSfs; i++) {
    sfXPositions[i] = random(width);
    sfYSpeeds[i] = random(1, 2);
    sfXSpeeds[i] = random(-2, 0.5);
    sfSizes[i] = random(20, 60);
  }
}

void draw () {
  //read file names every half a second
  if (frameCount % 30 == 0) {
    listFileNames(path);
  }
  //draw background
  background(0);
  setYGradient(0, 0, width, height, c1, c2);

  //snowflakes falling
  for (int i = 0; i < numSfs; i++) {
    image(snowflakes[i], sfXPositions[i], sfYPositions[i], sfSizes[i], sfSizes[i]);
  }

  for (int i = 0; i < numSfs; i++) {
    if (sfYPositions[i] < height/2) {
      sfXSpeeds[i] += 0.001;
    } else {
      sfXSpeeds[i] -= 0.002;
    }
  }
  for (int i = 0; i < numSfs; i++) {
    sfYPositions[i] += sfYSpeeds[i]; 
    sfXPositions[i] += sfXSpeeds[i];
    //sfXPositions[i] += sfXSpeeds[i];
    if (sfYPositions[i] > height || sfXPositions[i] < -100 || sfXPositions[i] > width + 50) {
      int j = int(random(0, files.size() - 1));
      snowflakes[i] = loadImage("snowflake/data/" + files.get(j), "png");
      //println("Loading image");
      sfYPositions[i] = -20;
      sfXPositions[i] = random(width);
      sfXSpeeds[i] = random(-2, 0.5);
    }
  }
}

//gradient func for background
void setYGradient(int x, int y, float w, float h, color c1, color c2) {
  noFill();
  for (int i = y; i <= y+h; i++) {
    float inter = map(i, y, y+h, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(x, i, x+w, i);
  }
}

//read png files in the directory
void listFileNames(String dir) {
  files.clear();
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    for (int i = 0; i < names.length; i++) {
      String extension = names[i].substring(names[i].length() - 3, names[i].length());
      if (extension.equals("png")) {
        files.add(names[i]);
      }
    }
  }
}