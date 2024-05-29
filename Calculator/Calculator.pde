Button butt;
Button plus;
Frame frame;
String disp = "";
void setup() {
    size(400,400); 
    rectMode(CORNERS);
    Screen newScreen = new Menu("test");
    String test = "test";
    newScreen.addLine(test);
    newScreen.addLine("2" + test + "2");
    newScreen.addLine(test + test + "2");
    newScreen.goUp(2);
    Frame frame = new Frame(20, 20, width-20, 200);
    frame.addScreen(newScreen);
    frame.changeScreen("test");
    frame.display();
  }
void draw(){
  //butt.display();
}

void mouseClicked(){
//butt.onClick();
//plus.onClick();
}
