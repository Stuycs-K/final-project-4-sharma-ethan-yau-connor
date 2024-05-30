abstract class Screen {
  String name;
  ArrayList<String> text;
  int topLine;
  int curLine;
  int maxCharsPerLine;
  int curChar;
  int fontSize;
  int smallFontSize;
  int maxLines;
  String TAG = "tag";
  
  String getName() {
    return name;
  }
  
  void addLine(String line){
    text.add(line);
    topLine++;
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
    if (curLine < topLine) topLine--;
    curChar = 0;
  }
  
  void goDown() {
    if (curLine < text.size()-1) curLine++;
    curChar = 0;
    
    if (curLine > topLine + maxLines - 1) topLine++;
  }
  void goUp(int lines) {
    curLine -= lines;
    if (curLine < 0) {
      curLine = 0;
    }
    
    if (curLine < topLine) {
      topLine --;
    }
    curChar = 0;
  }
  
  void highlightCurLine(float textWidth, float x, float y, float strHeight, float padding) {
    fill(20, 20, 100, 160);
    noStroke();
    rect(x-2, y-2, x + textWidth + 2, y + strHeight + 2);
    fill(0);
    stroke(0);
  }
  
  void leftJustify(boolean highlight, String text, float minX, float minY, float maxX, float maxY, float padding, float strHeight) {
    if (highlight) {
      highlightCurLine(textWidth(text), minX, minY, strHeight, textWidth(text));
    }
    text(text, minX, minY, maxX, maxY);
  }
  void display(float minX, float maxX, float minY, float maxY, float strHeight, float padding) {
    int count = 1;
    float curHeight = minY + padding;
    while (count < maxLines + 1 && (topLine + count - 1) <= text.size()-1) {
      fill(0);
      //print(text.get(topLine + count - 1));
      String line = text.get(topLine + count - 1);
      
      boolean rightJustify = false;
      if (line.equals("TAG")) {
        rightJustify = true;
      }
      
      if (line.length() >= maxCharsPerLine) {
        line = line.substring(curChar, curChar + maxCharsPerLine);
        textSize(smallFontSize);
        text("▶", maxX - textWidth("▶") - padding, curHeight + strHeight-10);
        textSize(fontSize);
      }
      
      boolean highlight = false;
      // highlight selected line
      if (topLine + count - 1 == curLine) highlight = true; 
      
      leftJustify(highlight, line, minX + padding, curHeight, maxX - padding, curHeight + strHeight, padding, strHeight);
      
      curHeight += padding + strHeight;
      rightJustify = false;
      highlight = false;
      fill(255);
      count++;
    }
  }
  
}
