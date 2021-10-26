public class Stage2 {
  Turtle t;
  Spotlight spot;
  Ghost ghost;
  Pumpkin pumpkin;
  PImage bg;

  public Stage2(Turtle turtle) {
    this.t = turtle;
    bg = loadImage("tunnel1.jpg");
    bg.resize(width, height);
    
    spot = new Spotlight();
    ghost = new Ghost(100, 5, "left");
    pumpkin = new Pumpkin(width, #FFA500);
    pumpkin.bounce();
    pumpkin.setBounceHeight(50);
    pumpkin.moveLeft(2);
  }

  int draw() {
    background(bg);
    ghost.draw();
    pumpkin.draw();
    t.draw();
    spot.draw();
    return 2;
  }


  void checkKeyReleased() {
    if ( key == CODED ) {
      if ( keyCode == LEFT || keyCode == RIGHT ) {
        t.stop();
      }
    }
  }

  void checkKeyPressed() {
    if ( keyPressed ) {
      if ( key == CODED ) {
        if ( keyCode == LEFT ) { 
          t.moveLeft();
        } else if ( keyCode == RIGHT ) {
          t.moveRight();
        } else if ( keyCode == DOWN ) {
          t.moveState = Turtle.SPIN;
        }
      } else {
        switch( key ) {
        case 's':
          t.shell();
          break;
        default:
          break;
        }
      }
    }
  }
}
