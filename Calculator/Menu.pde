class Menu extends Screen{
  
  Menu(String name, int maxCharsPerLine) {
    this.name = name;
    this.text = new ArrayList<String>();
    this.curLine = 0;
    curChar = 0;
    this.maxCharsPerLine = maxCharsPerLine;
    smallFontSize = 12;
    fontSize = 32;
  }
  
}
