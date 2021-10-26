public class Pumpkin {
  private int x;
  private int y;
  private int xSpeed = 0;
  private boolean bounce = false;
  private int bounceHeight = 30;
  private int bounceSpeed = 0;
  private int gravity = 1;
  private int pumpkinColor;
  private int pumpkinSizePixels = 150;
  private int glowingEyesColor = color(240 + random(15), 240 + random(15), random(255));
  private int greenStemColor = #2EA22C;

  public Pumpkin( int x, int pumpkinColor ) {
    this.x = x;
    this.y = height - 300;
    this.pumpkinColor = pumpkinColor;
  }

  public void setPumpkinColor( int newColor ){
    this.pumpkinColor = newColor;
  }

  // ---------------------------------------------------------
  // Call this method from the setup() method,
  // NOT the draw() method
  // ---------------------------------------------------------
  public void setBounceHeight( int newHeightInPixels ){
    this.bounceHeight = newHeightInPixels;
    this.y = newHeightInPixels;
  }
  
  public void bounce(){
    this.bounce = true;
  }
  
  public void stop(){
    this.bounce = false;
    this.xSpeed = 0;
  }
  
  public void moveRight( int speed ){
    this.xSpeed = speed;
  }
  
  public void moveLeft( int speed ){
    this.xSpeed = -speed;
  }

  public void draw(){
    push(); 

    if( bounceSpeed < bounceHeight ){
      bounceSpeed += gravity;
    }
    
    y += bounceSpeed;

    if( this.y > height - 200 ) {
      this.y = height - 200;

      if( bounce ) {
        bounceSpeed = -bounceSpeed;
      }
    }
    
    this.x += xSpeed;
    
    if( this.x > width + this.pumpkinSizePixels ){
      this.x = 0 - this.pumpkinSizePixels;
    }
    if( this.x < 0 - this.pumpkinSizePixels ){
      this.x = width;
    }

    ellipseMode(CENTER);

    // Black outline
    stroke(0);
    strokeWeight(2);

    // Draw top stem
    fill(greenStemColor);
    rect(x - 10, y - (pumpkinSizePixels/2) - 20, 15, 20);

    // Draw body
    fill(pumpkinColor);
    ellipse(x, y, pumpkinSizePixels, pumpkinSizePixels);

    // Set glowing eyes
    fill(glowingEyesColor, random(200) + 50 );  

    // Draw eyes
    triangle(x-30, y-20, x-20, y, x-40, y);
    triangle(x+30, y-20, x+20, y, x+40, y);
    triangle(x, y, x+10, y+20, x-10, y+20);

    // Draw shadow
    ellipse(x, height - 15, (150 * y) / height, (10 * y) / height);

    // Draw mouth
    arc(x, y + 30, 80, 80, 0, PI, 0);
    line(x - 40, y + 30, x + 40, y + 30);

    // Draw tooth  
    fill(this.pumpkinColor);
    rect(x + 10, y + 30, 10, 15);

    // Clear the top outline of the tooth
    strokeWeight(3);
    stroke(this.pumpkinColor);
    fill(this.pumpkinColor);
    line(x + 12, y + 30, x + 17, y + 30);

    pop();
  }
}
