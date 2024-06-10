class MiscButton extends Button {
  MiscButton(float Bheight, float Bwidth, float x, float y, String function) {
    this.Bheight = Bheight;
    this.Bwidth = Bwidth;
    this.x = x;
    this.y = y;
    name = function;
    disp = function;
  }
  MiscButton(float Bheight, float Bwidth, float x, float y, String function, String disp) {
    this(Bheight,Bwidth,x,y,function);
    this.disp = disp;
  }
  
  void operation() {
    if (name.equals("=")) {
      frame.submitNewLine();
    }
    if (name.equals("clear")) {
      frame.clearHistory();
    }
    if (name.equals("del")) {
      frame.delete();
    }
    if (name.equals("Ans")) {
      
    }
  }
}
