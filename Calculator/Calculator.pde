boolean press;
Button butt;
Button[] buttons;
Frame frame;
HashMap<String, Screen> screens;
int mousexpos;
int mouseypos;
String disp;
void setup(){
  textSize(64);
  mouseypos = 64;
  mousexpos = 0;
  size(500, 900);
  butt = new NumButton(400,400,20,20,"1");
}
void draw(){
   butt.onClick();
}
void mousePressed(){
  press = true;
}
void mouseReleased(){
  press = false;
}
