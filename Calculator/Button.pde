abstract class Button {
  float Bwidth;
  float Bheight;
  float x;
  float y;
  String name;
  Button second;
  Button alpha;
  boolean clicked = false;
  void onClick(){
   if(mouseX >= x && mouseY >= y && mouseX <= x + Bwidth && mouseY <= y + Bheight){
     operation();
     //println(name);
   }
  }
  
  void operation(){}
  void animate(){}
  void display(){
    fill(255);
    rect(x, y, x+Bwidth, y+Bheight, 5);
    fill(0);
    text(name, x, y + Bheight);
  }
}
