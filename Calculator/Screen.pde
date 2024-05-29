abstract class Screen {
  String name;
  ArrayList<String> text;
  int fontSize;
  int curLine;
  
  String getName() {
    return name;
  }
  
  void addLine(String line){
    text.add(line);
    curLine++;
  }
  
  void addLines(ArrayList<String> lines) {
    for (String line: lines) {
      text.add(line);
    }
  }
  
  void addLines(String[] lines) {
    for (String line: lines) {
      text.add(line);
    }
  }
  
  void goUp() {
    if (curLine > 0) curLine--;
  }
  
  void goDown() {
    if (curLine < text.size()-1) curLine++;
  }
  void goUp(int lines) {
    curLine -= lines;
    if (curLine < 0) {
      curLine = 0;
    }
    
  }
  void display(float minX, float maxX, float minY, float maxY, float strAscent, float padding) {
    int count = 1;
    float curHeight = minY + padding;
    while (count*strAscent < maxY - minY && (curLine + count - 1) <= text.size()-1) {
      fill(0);
      //print(text.get(curLine + count - 1));
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
