public class Spotlight {
  private ArrayList<Pixel> pixelList;
  private int pixelSize = 1;
  private int spotlightSizePixels = 150;
  private PImage darkness = null;
  private PGraphics spotlightMask = null;

  public Spotlight() {
    // Arraylist for pixelization
    pixelList = new ArrayList<Pixel>();

    // Foreground darkness image
    darkness = createImage(width, height, RGB);
    darkness.loadPixels();
    for ( int i = 0; i < darkness.pixels.length; i++ ) {
      darkness.pixels[i] = 0;
    }
    darkness.updatePixels();

    // Ellipse mask for spotlight through darkness with no pixel distortion
    if ( spotlightMask == null ) {
      spotlightMask = createGraphics(width, height);
    }
  }

  // Sets how pixelated the spotlight view is; 1 to 9
  // 1 = no pixelization
  // 9 = high pixelization (large pixels)
  public void setPixelSize( int sizePixels ) {
    this.pixelSize = sizePixels;
  }

  // Sets the spotlight ellipse size
  public void setSpotlightSize( int sizePixels ) {
    this.spotlightSizePixels = sizePixels;
  }
  
  public int getSize(){
    return this.spotlightSizePixels;
  }

  void initializePixels() {
    for ( int i = 0; i < width; i += pixelSize ) {
      for ( int j = 0; j < height; j+= pixelSize ) {
        color c = get(i, j);
        pixelList.add( new Pixel(i, j, pixelSize, c) );
      }
    }
  }

  void draw() {
    push();

    if ( pixelList.isEmpty() ) {
      initializePixels();
    }

    if ( pixelSize > 1 ) {
      // If pixelating

      background(0);

      for (int m = 0; m < pixelList.size (); m++) {
        Pixel p = (Pixel) pixelList.get(m);
        p.draw();
      }

      pixelList.clear();
    } else { 
      // Not pixelating, use a normal spotlight with no pixel distortion

      // Get current frame before draing darkness
      PImage currentFrame = get();
      
      image(darkness, 0, 0);

      spotlightMask.beginDraw();

      // Erase previously drawn graphics
      spotlightMask.background(0);
      spotlightMask.noStroke();

      // Ellipse mask with fuzzy edges
      for (int i=0; i<25; i++) {
        spotlightMask.fill(0+i*10);
        spotlightMask.ellipse(mouseX, mouseY, (2 * spotlightSizePixels) - (i * 2), (2 * spotlightSizePixels) - (i * 2));
      }

      spotlightMask.endDraw();

      currentFrame.mask(spotlightMask);
      image(currentFrame, 0, 0);
    }

    pop();
  }

  class Pixel {
    float x;
    float y;
    float pixelSize;
    color pixelColor;

    Pixel(float x, float y, float pixelSize, color pixelColor) {
      this.x = x;
      this.y = y;
      this.pixelSize = pixelSize;
      this.pixelColor = pixelColor;
    }

    void draw() {
      float xm, ym;
      float sizePixels = spotlightSizePixels * spotlightSizePixels;

      if ( ( (x - mouseX) * (x - mouseX) ) + ( (y - mouseY) * (y - mouseY) ) <= sizePixels ) {
        xm = x + random(-1, 1);
        ym = y + random(-1, 1);

        if (xm > width || xm < 0) {
          xm = -xm;
        }
        if (ym> height || ym<0) {
          ym = -ym;
        }

        fill(this.pixelColor); 
        rect(xm, ym, pixelSize, pixelSize);
      }
    }
  }
}
