Button butt;
Button plus;
Frame frame;
Screen screen;
int screenHeight;
int screenWidth;
HashMap<String, Screen> screens;
int mousexpos;
int mouseypos;
String disp = "";
void setup(){
  textSize(16);
  size(500, 900);
  butt = new NumButton(200,800,20,20,"1");
  plus = new NumButton(400,800,20,20,"+");
  CalcMath a = new CalcMath();
  //print(a.compute("(2+(2 % 2))^5+9%4-((4 + 8))"));
  //String s = "y+3y^2";
  //ArrayList<float[]> pts = a.graphPoints(s, 'y', 0.0, 10.0, 1);
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

void keyPressed() {
  //println(keyCode);
  if (key == CODED) {
    if (keyCode == UP) {
      frame.goUp();
    } else if (keyCode == DOWN) {
      frame.goDown();
    } else if (keyCode == LEFT) {
      frame.goLeft();
    } else if (keyCode == RIGHT) {
      frame.goRight();
    }
  }
  
  if (key == 'a') {
    frame.updateNewLine('a');
  }
  if (key == 'b') {
    frame.updateNewLine('b');
  }
  
  if (key == 'c') {
    print("enter");
    frame.submitNewLine();
  }
}
