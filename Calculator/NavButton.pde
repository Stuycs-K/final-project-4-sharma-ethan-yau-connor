class NavButton extends Button {
  NavButton(float Bheight, float Bwidth, float x, float y, String function) {
    this.Bheight = Bheight;
    this.Bwidth = Bwidth;
    this.x = x;
    this.y = y;
    name = function;
  }
  
  void operation() {
    if (name.equals("←")) {
      frame.goLeft();
    }
    else if (name.equals("→")) {
      frame.goRight();
    }
    else if (name.equals("↑")) {
      frame.goUp();
    }
    else if (name.equals("↓")) {
      frame.goDown();
    }
    else if (name.equals("graph")) {
      frame.newGraph();
      frame.changeScreen("graph");
      frame.curScreen.graphEquations();
    }
    else {
      frame.changeScreen(name);
    }
  }
}
