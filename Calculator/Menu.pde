class Menu extends Screen{
  
  Menu(String name, int fontSize) {
    this.name = name;
    this.fontSize = fontSize;
    this.text = new ArrayList<String>();
    this.curLine = 0;
    curChar = 0;
    maxCharsPerLine = 5;
  }
  
  Menu(String name) {
    this(name, 10);
  }
  
}
