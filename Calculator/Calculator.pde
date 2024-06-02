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
  size(500, 900);
  butt = new NumButton(200,800,20,20,"1");
  plus = new NumButton(400,800,20,20,"+");
  CalcMath a = new CalcMath();
  print(a.compute("(2+(2 % 2))^5+9%4-((4 + 8))"));
  rectMode(CORNERS);
  frame = new Frame(20, 20, 300);
}
void draw(){
  butt.display();
}

void mouseClicked(){
butt.onClick();
plus.onClick();
}
