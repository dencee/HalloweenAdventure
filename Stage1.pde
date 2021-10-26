class Stage1 {
  Turtle t;
  PImage bg, cage, dirt;
  int cageX, cageY;
  int dirtX, dirtY;
  int bgY = 0;
  boolean fall = false;
  ArrayList<Warp> warpList;

  public Stage1(Turtle turtle) {
    t = turtle;

    dirtX = width/2;
    dirtY = 4 * (height / 5);
    cageX = width/5;
    cageY = (height / 2) - 20;
    initialize();
  }

  public void initialize() {
    bg = loadImage("backyard.png");
    cage = loadImage("cage.png");
    dirt = loadImage("dirt.png");

    bg.resize(width, height);
    cage.resize(width/2, height/2);
    dirt.resize(120, 70);

    warpList = new ArrayList<Warp>();
    for (int i=0; i<10; i++) {
      warpList.add(new Warp((int)random(100)));
    }
  }

  int draw() {
    // Draw background
    if ( fall ) {
      bgY -= 10;
      dirtY -= 10;
      cageY -= 10;
      //background(0);
      fill(0, 32);
      rect(0, 0, width, height);
      noStroke();
      noFill();

      for ( Warp w : warpList ) {
        w.update();
        w.draw();
      }

      purgeWarp();
      addWarps();
    }

    image(bg, 0, bgY);

    // Draw dirt and hole in ground
    image(dirt, dirtX, dirtY);

    // Draw turtle
    t.draw();

    // Draw cage
    image(cage, cageX, cageY);

    if ( bgY < 6 * -height ) {
      t.stop();
      return 2;
    }
    return 1;
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
          if ( !fall ) { 
            t.moveLeft();
          }
        } else if ( keyCode == RIGHT ) {
          if ( !fall ) {
            t.moveRight();
          }
        } else if ( keyCode == DOWN ) {
          if ( t.x > width/2 && t.x < width/2 + dirt.width ) {
            fall = true;
            t.moveState = Turtle.SPIN;
          }
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

  void purgeWarp() {
    Iterator<Warp> it = warpList.iterator();
    while ( it.hasNext() ) {
      Warp w = it.next();
      if ( w.age > 100 ) {
        it.remove();
      }
    }
  }

  void addWarps() {
    if (warpList.size() < 200) {
      warpList.add(new Warp((int)random(100)));
    }
  }

  class Warp {
    int age;
    float angle;
    int warpBorder = 10;
    int warpWidth = 10;

    Warp(int age) {
      this.age = age;
      this.angle = random(TWO_PI);
    }

    void update() {
      age++;
    }

    void draw() {
      push();
      pushMatrix();
      translate(width/2, height/2);
      rotate(angle);
      for (int i=100; i>age; i--) {
        scale(0.975, 0.975);
      }
      fill(255, 128);
      strokeWeight(warpBorder);
      ellipse(0, width, warpWidth, warpWidth*5);
      popMatrix();
      pop();
    }
  }
}
