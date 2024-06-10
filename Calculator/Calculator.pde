Frame frame;
final String OS = platformNames[platform];
void setup(){
  textSize(16);
  size(500, 900);
  rectMode(CORNERS);
  frame = new Frame(20, 20, 300);
}
void draw(){
  frame.display();
}

void mouseClicked(){
  for (Button b : frame.buttons) {
    b.onClick();
  }
}
