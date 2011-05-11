int N = 2;  //Number of recursive steps

// Draw a Mondarian-inspired image using recursion
void piet(int x0, int y0, int x1, int y1, int N) {
 if (N == 0) {
    // Base case -- draw a colorful rectangle with a thick black border 
    int sw = 3; //this is the stroke width for the rectangle's border
    color c[] = { #ff0000, #00ff00, #0000ff, #ffff00, #ffffff}; //Mondarian color palatte
    fill(c[int(random(c.length))]);
    strokeWeight(sw);
    rect (x0,y0,x1-x0-sw,y1-y0-sw);
 } else {
    //Recursive step -- recursively break the current rectangle into 4 new random rectangles
    int i = int(random(x0,x1)); //Pick a random x coordinate inside the current rectangle
    int j = int(random(y0,y1)); //Pick a random y coordinate inside the current rectangle
    piet(x0,y0,i,j,N-1); // Recurse on upper left rectangle
    piet(i,y0,x1,j,N-1); // Recurse on upper right rectangle
    piet(x0,j,i,y1,N-1); // Recurse on lower left rectangle
    piet(i,j,x1,y1,N-1); // Recurse on lower right rectangle
 }
}

// keep draw() here to continue looping while waiting for keys
void draw() {
}

//Draw a new image each time a key is pressed
void keyPressed() { 
 piet(1,1,400,400, N );
}

//Draw the first image
void setup() {
 size(400,400);
 piet(1,1,400,400, N);
}
