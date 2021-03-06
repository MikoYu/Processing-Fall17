//references
/*openCV for processing > WhichFace
 * by Daniel Shiffman
 * http://shiffman.net/2011/04/26/opencv-matching-faces-over-time/
 * Modified by Jordi Tost (@jorditost) to work with the OpenCV library by Greg Borenstein:
 * https://github.com/atduskgreg/opencv-processing
 * @url: https://github.com/jorditost/BlobPersistence/
 */
/* video clip
 * https://www.videezy.com/people/4360-people-carrying-luggage-on-an-airport-4k-stock-video
 */

import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Movie mov;
Image movScaled;
OpenCV opencv;

ArrayList<Face> faceList; // List of my Face objects (persistent)
Rectangle[] faces;  // List of detected faces (every frame)
int faceCount = 0;  // Number of faces detected over all time. Used to set IDs.
int scl = 2;  // Scaling down the video
float faceB;

void setup() {
  size(1920, 1080);
  frameRate(12);
  background(0);

  mov = new Movie(this, "crowd1.mp4");
  mov.loop();
  mov.volume(0);

  opencv = new OpenCV(this, width/scl, height/scl);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  faceList = new ArrayList<Face>();
}

void movieEvent(Movie mov) {
  mov.read();
}

void draw() {
  background(0);
  //make a smaller image to give to opencv
  PImage decimatedImage = mov.copy();
  decimatedImage.resize(1920 / scl, 0);
  opencv.loadImage(decimatedImage);
  image(mov, 0, 0);

  detectFaces();

  //calculate brightness
  for (int i = 0; i < faces.length; i++) {
    float sumB = 0;
    for (int j = 0; j < 20; j++) {
      int ranX = faces[i].x + (int)random(faces[i].width);
      int ranY = faces[i].y + (int)random(faces[i].height);
      sumB += brightness(mov.get(ranX, ranY));
    }
    faceB = sumB/20;
  }
  

  for (Face f : faceList) {
    tint(faceB * 2);
    f.display();
    tint(255);
  }
}

void detectFaces() {

  // Faces detected in this frame
  faces = opencv.detect();

  // Check if the detected faces already exist are new or some has disappeared. 

  // SCENARIO 1 
  // faceList is empty
  if (faceList.isEmpty()) {
    // Just make a Face object for every face Rectangle
    for (int i = 0; i < faces.length; i++) {
      println("+++ New face detected with ID: " + faceCount);
      faceList.add(new Face(faceCount, faces[i].x, faces[i].y, faces[i].width, faces[i].height));
      faceCount++;
    }

    // SCENARIO 2 
    // We have fewer Face objects than face Rectangles found from OPENCV
  } else if (faceList.size() <= faces.length) {
    boolean[] used = new boolean[faces.length];
    // Match existing Face objects with a Rectangle
    for (Face f : faceList) {
      // Find faces[index] that is closest to face f
      // set used[index] to true so that it can't be used twice
      float record = 50000;
      int index = -1;
      for (int i = 0; i < faces.length; i++) {
        float d = dist(faces[i].x, faces[i].y, f.r.x, f.r.y);
        if (d < record && !used[i]) {
          record = d;
          index = i;
        }
      }
      // Update Face object location
      used[index] = true;
      f.update(faces[index]);
    }
    // Add any unused faces
    for (int i = 0; i < faces.length; i++) {
      if (!used[i]) {
        println("+++ New face detected with ID: " + faceCount);
        faceList.add(new Face(faceCount, faces[i].x, faces[i].y, faces[i].width, faces[i].height));
        faceCount++;
      }
    }

    // SCENARIO 3 
    // We have more Face objects than face Rectangles found
  } else {
    // All Face objects start out as available
    for (Face f : faceList) {
      f.available = true;
    } 
    // Match Rectangle with a Face object
    for (int i = 0; i < faces.length; i++) {
      // Find face object closest to faces[i] Rectangle
      // set available to false
      float record = 50000;
      int index = -1;
      for (int j = 0; j < faceList.size(); j++) {
        Face f = faceList.get(j);
        float d = dist(faces[i].x, faces[i].y, f.r.x, f.r.y);
        if (d < record && f.available) {
          record = d;
          index = j;
        }
      }
      // Update Face object location
      Face f = faceList.get(index);
      f.available = false;
      f.update(faces[i]);
    } 
    // Start to kill any left over Face objects
    for (Face f : faceList) {
      if (f.available) {
        f.countDown();
        if (f.dead()) {
          f.delete = true;
        }
      }
    }
  }

  // Delete any that should be deleted
  for (int i = faceList.size()-1; i >= 0; i--) {
    Face f = faceList.get(i);
    if (f.delete) {
      faceList.remove(i);
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}