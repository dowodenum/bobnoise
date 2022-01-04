//optional for exporting a video:

//import com.hamoid.*;
//VideoExport videoExport;

PImage bob;

//holds initial framecount when locking
int count = 0;
//sets (or used to hold random) number of frames to freeze
int freezetime = 0;
//whether or not the masked pixels are locked
boolean lock = false;


void setup()
{
  frameRate(30);
  size(500, 500);
  
  //must use a black/white image of same size as frame
  bob = loadImage("bob.png");
  imageMode(CENTER);

  //optional for exporting a video:
  //videoExport = new VideoExport(this);
  //videoExport.startMovie();
}

void draw()
{
  loadPixels();
  
  //loop through pixels in frame
  for (int i = 0; i < pixels.length; i++) {
    //if we're currently locked,
    if (lock) {
      //and we're outside the mask (255 = white)
      if (bob.pixels[i] == color(255)) {
        //generate a black/white pixel
        pixels[i] = BW();
      }
    //if we're not locked
    } else {
      //generate all-new pixels
      pixels[i] = BW();
    }
  }

  updatePixels();

  //rarely lock the pixels within the black area of the masking image
  //currently set to 5% chance (1 - 0.95)
  //and randomly generate a number of frames to freeze for
  if (random(0, 1) > 0.95 && !lock) {
    lock = true;
    count = frameCount;
    freezetime = (int)random(1, 4);
  }

  //if locked and has been frozen for X frames, unlock
  if (lock && (frameCount - count) > freezetime) {
    lock = false;
  }

  //optional to export video:
  //videoExport.saveFrame();
}

int BW()
{
  return color((int)random(0,2) * 255);
}


void keyPressed() {
  if (key == 'q') {
    //optional to export video:
    //videoExport.endMovie();
    exit();
  }
}
