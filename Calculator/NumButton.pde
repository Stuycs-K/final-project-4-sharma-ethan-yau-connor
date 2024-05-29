class NumButton extends Button{
  NumButton(int startx, int starty, int wid, int heigh, String name1){
    x=startx;
    y=starty;
    Bheight=heigh;
    Bwidth=wid;
    fill(255);
    rect(startx,starty,wid,heigh,3);
    name = name1;
    fill(0);
    
    text(name, startx + wid / 3,starty + heigh / 1.2);
  }
}
