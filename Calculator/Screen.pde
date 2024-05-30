abstract class Screen {
  String name;
  ArrayList<String> text;
  int curLine;
  int maxCharsPerLine;
  int curChar;
  int fontSize;
  int smallFontSize;
  
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
    curChar = 0;
  }
  
  void goDown() {
    if (curLine < text.size()-1) curLine++;
    curChar = 0;
  }
  void goUp(int lines) {
    curLine -= lines;
    if (curLine < 0) {
      curLine = 0;
    }
    curChar = 0;
  }
  void display(float minX, float maxX, float minY, float maxY, float strHeight, float padding) {
    int count = 1;
    float curHeight = minY + padding;
    while (count*strHeight < maxY - minY && (curLine + count - 1) <= text.size()-1) {
      fill(0);
      //print(text.get(curLine + count - 1));
      String line = text.get(curLine + count - 1);
      if (line.length() >= maxCharsPerLine) {
        line = line.substring(curChar, curChar + maxCharsPerLine);
        textSize(smallFontSize);
        text("▶", maxX - textWidth("▶") - padding, curHeight + strHeight-10);
        textSize(fontSize);
      }

      text(line, minX + padding, curHeight, maxX - padding, curHeight + strHeight);
      curHeight += padding + strHeight;
      fill(255);
      count++;
    }
  }
  
}
