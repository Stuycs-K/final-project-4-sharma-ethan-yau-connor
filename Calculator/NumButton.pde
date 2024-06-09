class NumButton extends Button{
  NumButton(float Bheight, float Bwidth, float x, float y, String function) {
    this.Bheight = Bheight;
    this.Bwidth = Bwidth;
    this.x = x;
    this.y = y;
    name = function;
    disp = function;
  }
  NumButton(float Bheight, float Bwidth, float x, float y, String function, String disp) {
    this(Bheight,Bwidth,x,y,function);
    fill(255);
    this.disp = disp;
    fill(0);
  }
  
  void operation() {
    for(int i = 0; i < name.length(); i++){
      frame.updateNewLine(name.charAt(i));
    }
  }
}
