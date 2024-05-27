Button butt;
Button[] buttons;
Frame frame;
Screen screen;
HashMap<String, Screen> screens;
int mousexpos;
int mouseypos;
String disp = "";
void setup(){
  textSize(32);
  screen = new Screen("default", 300,480);
  size(500, 900);
  butt = new NumButton(400,400,20,20,"1");
}
void draw(){
  butt.display();
}

void mouseClicked(){
butt.onClick();
}
