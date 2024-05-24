import com.krab.lazy.*;

LazyGui gui;

Button[] buttons;
Frame frame;
HashMap<String, Screen> screens;

void setup(){
  size(1000, 800, P3D);
  gui = new LazyGui(this);
  if(gui.button("1")){
    println("it is done");
}
}
void draw(){
    background(gui.colorPicker("background").hex);
}
