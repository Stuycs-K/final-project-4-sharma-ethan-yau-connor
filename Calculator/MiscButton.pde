class MiscButton extends Button {
  MiscButton(float Bheight, float Bwidth, float x, float y, String function) {
    this.Bheight = Bheight;
    this.Bwidth = Bwidth;
    this.x = x;
    this.y = y;
    name = function;
  }
  
  void operation() {
    if (name.equals("=")) {
      frame.submitNewLine();
    }
    if (name.equals("X")) {
      frame.clearHistory();
    }
    if (name.equals("del")) {
      
    }
  }
}
