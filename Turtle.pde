public class Turtle {
  public static final int STILL = -1;           // Non-moving object
  public static final int MOVE_BY_MOUSE = 1;    // Move by mouse drag
  public static final int MOVE_CONSTANT = 2;    // Move at a constant speed
  public static final int MOVE_KEYS = 3;        // Move with direction keys
  public static final int SHELL = 4;            // Turtle in shell
  public static final int SPIN = 5;             // Spinning turtle

  int x, y, w, h, xSpeed, angleDeg, moveState;
  int leftLimit, rightLimit;
  int numWalkImages, numShellImages, frameIndex, frameShellIndex;
  int now, updateFreqMs;
  String turtleType, direction;
  PImage stillR, stillL;
  PImage[] imagesR, imagesL, imagesShellR, imagesShellL;
  boolean isAlive;

  public Turtle(int x, int y) {
    this.x = x;
    this.y = y;
    this.xSpeed = 0;
    this.leftLimit = 0;
    this.rightLimit = width;
    this.angleDeg = 0;        // facing east
    this.isAlive = true;
    this.moveState = Turtle.STILL;
    this.direction = "right";
    this.turtleType = "turtle";
    this.numWalkImages = 20;
    this.numShellImages = 3;
    this.w = 500/3;
    this.h = 352/3;
    this.imagesR = new PImage[numWalkImages];
    this.imagesL = new PImage[numWalkImages];
    this.imagesShellR = new PImage[numShellImages];
    this.imagesShellL = new PImage[numShellImages];

    loadImages(turtleType, w, h);
    this.stillR = this.imagesR[0];
    this.stillL = this.imagesL[0];

    this.frameIndex = 0;
    this.frameShellIndex = 0;
    this.updateFreqMs = 50;
    this.now = millis();
  }

  void draw() {
    push();
    imageMode(CENTER);

    if ( millis() - now > updateFreqMs ) {
      this.frameIndex = ++this.frameIndex % this.numWalkImages;
      this.frameShellIndex++;
      this.now = millis();
    }

    if ( moveState == Turtle.STILL ) {
      if ( direction.equals("right") ) {
        image(this.stillR, x, y);
      } else {
        image(this.stillL, x, y);
      }
    } else if ( moveState == Turtle.MOVE_BY_MOUSE ) {
      if ( mouseX > x && this.direction.equals("left") ) {
        this.direction = "right";
      } else if ( mouseX < x && this.direction.equals("right") ) {
        this.direction = "left";
      }

      if ( direction.equals("right") ) {
        image(imagesR[frameIndex], x, y);
      } else {
        image(imagesL[frameIndex], x, y);
      }
    } else if ( moveState == Turtle.MOVE_CONSTANT ) {
      if ( direction.equals("right") ) {
        image(imagesR[frameIndex], x, y);
      } else {
        image(imagesL[frameIndex], x, y);
      }
    } else if ( moveState == Turtle.MOVE_KEYS ) {
      //if ( x + stillR.width -  2 > leftLimit && x + stillR.width + 2 < rightLimit ) {
        this.x += this.xSpeed;
      //}
      if ( direction.equals("right") ) {
        image(imagesR[frameIndex], x, y);
      } else {
        image(imagesL[frameIndex], x, y);
      }
    } else if ( moveState == Turtle.SHELL ) {
      if ( frameShellIndex >= numShellImages ) {
        frameShellIndex = numShellImages - 1;
      }

      if ( direction.equals("right") ) {
        image(imagesShellR[frameShellIndex], x, y);
      } else {
        image(imagesShellL[frameShellIndex], x, y);
      }
    } else if ( moveState == Turtle.SPIN ) {
      pushMatrix();
      translate(x, y);
      rotate(radians(angleDeg));
      angleDeg += 10;

      if ( direction.equals("right") ) {
        image(this.stillR, 0, 0);
      } else {
        image(this.stillL, 0, 0);
      }

      popMatrix();
    }

    pop();
  }

  void setLeftLimit(int limit) {
    this.leftLimit = limit;
  }

  void setRightLimit(int limit) {
    this.rightLimit = limit;
  }

  void moveLeft() {
    this.moveState = Turtle.MOVE_KEYS;
    this.direction = "left";
    this.xSpeed = -2;
  }

  void moveRight() {
    this.moveState = Turtle.MOVE_KEYS;
    this.direction = "right";
    this.xSpeed = 2;
  }

  void shell() {
    if ( this.moveState == Turtle.SHELL ) {
      unShell();
    } else {
      // Enter shell

      stop();
      this.frameShellIndex = 0;
      this.moveState = Turtle.SHELL;
      this.stillR = this.imagesShellR[0];
      this.stillL = this.imagesShellL[0];
    }
  }

  void unShell() {
    stop();
    this.moveState = Turtle.STILL;
    this.stillR = this.imagesR[0];
    this.stillL = this.imagesL[0];
  }

  void spin() {
    if ( this.moveState == Turtle.SPIN ) {
      stop();
      this.moveState = Turtle.STILL;
    } else {
      stop();
      this.moveState = Turtle.SPIN;
    }
  }

  void followMouse() {
    // Only move if mouse is over the turtle
    if ( moveState == Turtle.STILL ) {
      if ( mouseX < this.x - (this.w / 2) || mouseX > this.x + (this.w / 2) ||
        mouseY < this.y - (this.h / 2) || mouseY > this.y + (this.h / 2) )
      {
        return;
      }
    }

    if ( mouseX > this.x && this.direction.equals("left") ) {
      this.direction = "right";
    } else if ( mouseX < this.x && this.direction.equals("right") ) {
      this.direction = "left";
    }

    this.moveState = Turtle.MOVE_BY_MOUSE;
    this.x = mouseX;
    this.y = mouseY;
  }

  void stop() {
    this.moveState = Turtle.STILL;
  }

  void loadImages(String turtleType, int w, int h) {
    String filename;
    PImage image;
    int totalImages = this.numWalkImages + this.numShellImages;

    for ( int i = 0; i < totalImages; i++ ) {
      filename = turtleType + i + "_L.png";
      image = loadImage(filename);
      image.resize(w, h);
      if ( i < this.numWalkImages ) {
        this.imagesL[i] = image;
      } else {
        this.imagesShellL[i - this.numWalkImages] = image;
      }

      filename = turtleType + i + "_R.png";
      image = loadImage(filename);
      image.resize(w, h);
      if ( i < this.numWalkImages ) {
        this.imagesR[i] = image;
      } else {
        this.imagesShellR[i - this.numWalkImages] = image;
      }
    }
  }
}
