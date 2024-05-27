public abstract class Button {
  int Bwidth;
  int Bheight;
  int x;
  int y;
  String name;
  Button second;
  Button alpha;
  void onClick(){
   if(mouseX >= x && mouseY >= y && mouseX <= x + Bwidth && mouseY <= y + Bheight){
     disp += name;
     
   }
  }
  void animate(){};
  void display(){
    fill(0,1,123);
    text(disp, 0, 64);
  };
}
