Button butt;
Button plus;
Frame frame;
String disp = "";
void setup() {
    Screen newScreen = new Menu("test");
    String test = "test";
    newScreen.addLine(test);
    newScreen.display(20, 100, 20, 50, 20);
  }
void draw(){
  butt.display();
}

void mouseClicked(){
butt.onClick();
plus.onClick();
}
