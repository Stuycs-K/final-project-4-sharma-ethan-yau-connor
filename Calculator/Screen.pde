public abstract class Screen {
  String name;
  ArrayList<String> text;
  int fontSize;
  int curLine;
  
  public String getName() {
    return name;
  }
  
  public void addLine(String line){
    text.add(line);
    curLine++;
  }
  
  public void goUp() {
    if (curLine > 0) curLine--;
  }
  
  public void goUp(int lines) {
    curLine -= lines;
    if (curLine < 0) {
      curLine = 0;
    }
    
  }
  public void display(float minX, float maxX, float minY, float maxY, float strAscent, float padding) {
    int count = 1;
    float curHeight = minY + padding;
    while (count*strAscent < maxY - minY && (curLine + count - 1) < text.size()) {
      fill(0);
      print(text.get(curLine + count - 1));
      text(text.get(curLine + count - 1), minX + padding, 
                              curHeight, 
                              maxX - padding, 
                              curHeight + 2*strAscent);
      curHeight += padding + strAscent;
      fill(255);
      count++;
    }
  }
  
}
