class Graph extends Screen {
  
  Graph(String name, int maxCharsPerLine, int maxLines, float minX, float maxX, float minY, float maxY, float strHeight, float padding, float textWidth) {
    this.name = name;
    this.text = new ArrayList<String>();
    this.topLine = 0;
    curChar = 0;
    selectedChar = 0;
    this.maxCharsPerLine = maxCharsPerLine;
    this.curLine = 0;
    smallFontSize = 12;
    fontSize = 32;
    this.maxLines = maxLines;
    this.minX = minX;
    this.maxX = maxX;
    this.minY = minY;
    this.maxY = maxY;
    this.strHeight = strHeight;
    this.padding = padding;
    this.textWidth = textWidth;
  }
  
  void submitNewLine() {}
  void clearHistory() {}
  void delete() {}
  void display() {}
  void goUp(){}
  void goDown(){}
  void goRight(){}
  void goLeft(){}
  
}
