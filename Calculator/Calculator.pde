Button butt;
Button plus;
ArrayList<Button> buttons;
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
  screen = new Screen("default", 300,480);
  size(500, 900);
  butt = new NumButton(200,800,20,20,"1");
  plus = new NumButton(400,800,20,20,"+");
}
void draw(){
  butt.display();
}

void mouseClicked(){
butt.onClick();
plus.onClick();
}
