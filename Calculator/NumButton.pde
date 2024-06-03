class NumButton extends Button{
  NumButton(float heigh, float wid, float startx, float starty, String name1){
    x=startx;
    y=starty;
    Bheight=heigh;
    Bwidth=wid;
    fill(255);
    name = name1;
    fill(0);
  }
  
  void operation() {
    
    frame.updateNewLine(name.charAt(0));
  }
}
