Button butt;
Button plus;
Frame frame;
String disp = "";
void setup() {
    Screen newScreen = new Menu("test");
    String test = "test";
    newScreen.addLine(test);
    Frame frame = new Frame(20, 200, 20, 200);
    frame.addScreen(newScreen);
    frame.changeScreen("test");
    frame.display();
  }
void draw(){
  butt.display();
}

void mouseClicked(){
butt.onClick();
plus.onClick();
}
