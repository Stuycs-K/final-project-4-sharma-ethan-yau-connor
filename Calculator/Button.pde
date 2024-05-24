public abstract class Button {
  int Bwidth;
  int Bheight;
  int x;
  int y;
  String name;
  Button second;
  Button alpha;
  void onClick(){
   if(press && mouseX >= x && mouseY >= y && mouseX <= x + Bwidth && mouseY <= y + Bheight){
     fill(0,1,123);
     text(name, mousexpos, mouseypos);
     mousexpos += 32;
     if(mousexpos > width){
     mousexpos=0;
     mouseypos += 64;
     }
   }
  }
  void animate(){};
}
