class Menu extends Screen{
  
  Menu(String name, int maxCharsPerLine, int maxLines) {
    this.name = name;
    this.text = new ArrayList<String>();
    this.topLine = 0;
    curChar = 0;
    this.maxCharsPerLine = maxCharsPerLine;
    this.curLine = 0;
    smallFontSize = 12;
    fontSize = 32;
    this.maxLines = maxLines;
  }
  
}
