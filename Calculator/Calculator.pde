import com.krab.lazy.*;
boolean press;
LazyGui gui;
Button butt;
Button[] buttons;
Frame frame;
HashMap<String, Screen> screens;
void setup(){
  textSize(128);
  size(500, 900, P3D);
  //gui = new LazyGui(this);
  //gui.button("2");
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
