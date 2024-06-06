class GraphMenu extends Screen {
  String[] equations;
  int maxEquations;
  int leftMostChar;
  int curChar;
  int selectedChar;
  String selectedLine;
  int prefixLength;
  
  GraphMenu(String name, int maxCharsPerLine, int maxLines, float minX, float maxX, float minY, float maxY, float strHeight, float padding, float textWidth, int maxEquations) {
    this.name = name;
    this.text = new ArrayList<String>();
    this.topLine = 0;
    curChar = 0;
    selectedChar = 0;
    this.maxCharsPerLine = maxCharsPerLine;
    this.curLine = 0;
    smallFontSize = 12;
    fontSize = 32;
    this.selectedLine = "";
    this.minX = minX;
    this.maxX = maxX;
    this.minY = minY;
    this.maxY = maxY;
    this.strHeight = strHeight;
    this.padding = padding;
    this.textWidth = textWidth;
    this.maxEquations = maxEquations;
    this.maxLines = maxLines;
    equations = new String[maxEquations];
    for (int i = 0; i < maxEquations; i++) {
      equations[i] = "";
    }
    leftMostChar = 0;
    curChar = 0;
    selectedChar = 0;
    prefixLength = 0;
  }
  
  void submitNewLine() {goDown();}
  void clearHistory() {
    equations[curLine + topLine] = "";
    curChar = 0;
    selectedChar = 0;
    leftMostChar = 0;
    selectedLine = "";
  }
  void delete() {}
  void display() {
    int count = 0;
    float curHeight = minY + padding;
    
    selectedLine = equations[curLine + topLine];
    while (curHeight < maxY - padding && count < maxLines) {
      String eq = equations[count + topLine];
      if (eq == null) {
        eq = "";
      }
      String prefix = String.format("%-3s", "Y" + (count+1+topLine) ) + "=";
      prefixLength = prefix.length();
      
      String text = eq;
      //check if equation is the longer than possible
      int maxChars = maxCharsPerLine - prefixLength;
      int startChar = 0;
      
      if (count == curLine) {
        float offset = textWidth(prefix);
        float charOffset = curChar * textWidth;
        blinkBox(minX + padding + offset + charOffset, curHeight);
        startChar = leftMostChar;
      }
      
      if (eq.length() > maxChars) {
        text = eq.substring(startChar, startChar + maxChars);
      }
      
      displayEquation(prefix, text, curHeight);
      
      curHeight += strHeight;
      count++;
    }
  }
  void displayEquation(String prefix, String eq, float curHeight) {
    
    String text = prefix + eq;
    leftJustify(text, curHeight);
    
  }
  
  void addToNewLine(char c) {
    String text = equations[topLine + curLine];
    if (selectedChar == text.length()) {
      equations[topLine + curLine] += c;

    }
    else {
      equations[topLine + curLine] = text.substring(0, selectedChar) + c + text.substring(selectedChar+1);
    }
    selectedLine = equations[topLine + curLine];
    goRight();
  } 
  void overflow() {}
  
  void rightOverFlow(float maxX, float curHeight) {
    textSize(smallFontSize);
    text("▶", maxX - textWidth("▶"), curHeight + strHeight-10);
    textSize(fontSize);
    
  }
  
  void leftOverFlow(float minX, float curHeight) {
    textSize(smallFontSize);
    text("◀", minX, curHeight + strHeight-10);
    textSize(fontSize);
  }
  
  void leftJustify(String text, float curHeight) {

    float minX = this.minX + padding;
    float minY = curHeight;
    float maxX = this.maxX - padding;
    float maxY = curHeight + strHeight; 
    
    fill(0);
    text(text, minX, minY, maxX, maxY);
    fill(255);
  }
  
  void blinkBox(float minX, float minY) {
    int speed = 30;
    float w = textWidth(".");
    stroke(255);
    if ((frameCount / speed) % 2 == 0) {
      fill(0);
    } else {
      fill(255);
    }
    rect(minX, minY - 5, minX + w, minY + strHeight);
    
    fill(255);
    stroke(0);
  }
  
  void goUp() {
    if (curLine > 0) curLine--;
    else if (curLine < topLine && topLine > 0) topLine --;
    curChar = 0;
    leftMostChar = 0;
    selectedChar = 0;
    //println(curLine + " " + topLine);
  }
  
  void goDown() {

    if (curLine < maxLines - 1) curLine++;
    else if (topLine + curLine < maxLines - 1) topLine++;
    curChar = 0;
    leftMostChar = 0;
    selectedChar = 0;
    //println(curLine + " " + topLine);
  }
  
  void goRight(){
    int maxChars;
    if (selectedLine != null) {
      maxChars = selectedLine.length();
    } else {
      maxChars = 0;
    }
    if (prefixLength + curChar < maxCharsPerLine && curChar < maxChars) {
      curChar++;
    } else if (selectedChar < maxChars) {
      leftMostChar++;
    }
    selectedChar = curChar + leftMostChar;
  }
  
  void goLeft(){
    if (curChar > 0) {
      curChar--;
    } else if (leftMostChar > 0) {
      leftMostChar --;
    }
    selectedChar = curChar + leftMostChar;
  }
  
  void addLines(String[] lines) {
    int count = 0;
    for (String line: lines) {
      equations[count] = line;
      count++;
      if (count >= maxEquations) break;
    }
  }
  
}
