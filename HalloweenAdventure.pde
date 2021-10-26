import java.util.*;
Turtle turtle;
int stage = 1;
Stage1 s1;
Stage2 s2;

void setup() {
  size(1000, 600);
  turtle = new Turtle(width/3, 4 * height/5);
  s1 = new Stage1(turtle);
  s2 = new Stage2(turtle);
}

void draw() {

  switch( stage ) {
  case 1:
    stage = s1.draw();
    break;
  case 2:
    stage = s2.draw();
  default:
    break;
  }
}

void keyPressed(){
  switch( stage ) {
  case 1:
    s1.checkKeyPressed();
    break;
  case 2:
    s2.checkKeyPressed();
    break;
  default:
    break;
  }
}  
  
void keyReleased() {
  switch( stage ) {
  case 1:
    s1.checkKeyReleased();
    break;
  case 2:
    s2.checkKeyReleased();
    break;
  default:
    break;
  }
}
