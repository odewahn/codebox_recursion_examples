import controlP5.*;  

ControlP5 controlP5;

int depthSlider = 0; //controls the reciursive depth
int MIN_DEPTH = 0;
int MAX_DEPTH = 6;


// Implements a Vector
class Vector {
  float x,y,r, theta;
  
  Vector (float _x, float _y, float _r, float _theta) {
    x = _x;  //Origin x
    y = _y;  //Origin y
    r = _r;  //Length
    theta = _theta;  // Angle
  }
  
  float getEndX() { 
    return x + r*cos(theta/57.3);
  }
  
  float getEndY() {
    return y + r*sin(theta/57.3);
  }
  
  void drawVector() {
     line(x,y,getEndX(),getEndY());  //Draw the current vector
  }
  
}

//Recursive function that creates a fractal "plant" 
void fractal(Vector v, int N) {
  if (N == 0) {
     v.drawVector();  //Draw the current vector
  } else {
     Vector t1 = new Vector(v.x,v.y,v.r/3.0,v.theta);
     Vector t2 = new Vector(t1.getEndX(), t1.getEndY(), v.r/3.0, v.theta + 60.0);
     Vector t3 = new Vector(t2.getEndX(), t2.getEndY(), v.r/3.0,v.theta - 60.0);
     Vector t4 = new Vector(t3.getEndX(), t3.getEndY(), v.r/3.0,v.theta);
     fractal(t1,N-1);  //Recurse
     fractal(t2,N-1);  //Recurse
     fractal(t3,N-1);  //Recurse
     fractal(t4,N-1);  //Recurse
  }
}

//This method is called when one of the controlP5 controls is activated.
//Note that the Id in the switch statement must match the Id when the control is created
public void controlEvent(ControlEvent theEvent) {
  switch(theEvent.controller().id()) {
    case(1):
    //The depth slider was changed
    keyPressed();
    break;
  }
}
    

// keep draw() here to continue looping while waiting for keys
void draw() {
}

//Draw a new image each time a key is pressed
void keyPressed() { 
   fill(#556b2f);
   stroke(#fffff0);
   smooth();
   rect(0,0,400,400);
   Vector seed = new Vector(200,40,300,120);
   fractal (seed,depthSlider);
   seed = new Vector(350,300,300,-120);
   fractal (seed,depthSlider);
   seed = new Vector(50,300,300,0);
   fractal (seed,depthSlider);
   
}

//Draw the first image
void setup() {
   size(400,400);
   controlP5 = new ControlP5(this);
   controlP5.addSlider("depthSlider",MIN_DEPTH,MAX_DEPTH,depthSlider,20,20,100,10).setId(1);
   Slider s2 = (Slider)controlP5.controller("depthSlider"); //Get a handle to the new slider
   s2.setNumberOfTickMarks(MAX_DEPTH);  // Set tick marks
   s2.setLabel("Recursive Depth");
   keyPressed();
}
