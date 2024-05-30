Button butt;
Button plus;
Frame frame;
String disp = "";
void setup() {
    size(500,750); 
    rectMode(CORNERS);
    frame = new Frame(20, 20, 300);
    print(frame.strHeight);
  }
void draw(){
  //butt.display();
  frame.display();
}

void mouseClicked(){
//butt.onClick();
//plus.onClick();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      frame.goUp();
    } else if (keyCode == DOWN) {
      frame.goDown();
    }
  }
}
