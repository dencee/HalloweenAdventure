public class Ghost {
  private PImage ghostImg;
  private String direction;
  private int x;
  private int y;
  private int speed = 5;
  private int transparency = 125;

  public Ghost(int y, int speed, String direction) {
    ghostImg = loadImage( "ghost.png" );
    ghostImg.resize(150, 250);
    
    this.direction = direction;
    this.speed = speed;
    this.x = -ghostImg.width;
    this.y = y;
  }
  
  // 0 = most transparent; 100 = most opaque
  public void setGhostTransparency( int transparency ){
    // Normalize value from 0-255
    this.transparency = ( 255 - ( ( transparency * 255 ) / 100 ) );
  }

  void draw() {
    push();

    // Makes ghost transparent
    tint(255, this.transparency);
    
    if( direction.equalsIgnoreCase("left") ){
      // Ghost goes right to left
      
      // Flip on X axis
      scale(-1,1);
      image(ghostImg, -this.x, this.y);
      
      this.x -= speed;
      
      if( this.x < -ghostImg.width ){
        this.x = width + ghostImg.width;
        
      }
    } else {
      // Ghost goes left to right
      
      image( ghostImg, this.x, this.y );
      
      this.x += speed;
      
      if ( this.x > width ) {
        this.x = -ghostImg.width;
      }
    }
    
    pop();
  }
}
