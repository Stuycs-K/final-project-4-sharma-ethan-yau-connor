class Frame {
  ArrayList<Button> buttons;
  Screen curScreen;
  HashMap<String, Screen> screens;
  float screenMinX;
  float screenMinY;
  float screenMaxX;
  float screenMaxY;
  PFont font;
  float strAscent;
  float strDescent;
  float strHeight;
  float padding;
  float buttonHeight;
  float buttonWidth;
  float buttonFont;
  int maxCharsPerLine;
  
  Frame(float screenMinX, float screenMinY, float screenHeight) {
    buttons = new ArrayList<Button>();
    screens = new HashMap<String, Screen>();
    
    //stuff for font
    font = createFont("Monospaced", 32);
    textFont(font);
    strAscent = textAscent();
    strDescent = textDescent();
    strHeight = strAscent + strDescent;
    padding = 10;
    maxCharsPerLine = (int) Math.floor((width - 2*screenMinX - 2*padding)/textWidth("a"));
    this.screenMinX = screenMinX;
    this.screenMinY = screenMinY;
    screenMaxX = width - screenMinX;
    screenMaxY = screenMinY + screenHeight;
    buttonHeight = 25;
    buttonWidth = 25;
    
    newMainScreen("main");
    changeScreen("main");
    String[] test = {"abc","tagABC","..1234565","tagabcdefghijklmnopqrstuvwxyz", "a", "tagab", "abc", "abcd", "123"};
    addLines(test);
    
    buttons.add(new NavButton(buttonHeight, buttonWidth,  10, screenMaxY + 100, "←"));
    buttons.add(new NavButton(buttonHeight, buttonWidth,  60, screenMaxY + 40, "↑"));
    buttons.add(new NavButton(buttonHeight, buttonWidth,  60, screenMaxY + 160, "↓"));
    buttons.add(new NavButton(buttonHeight, buttonWidth,  110, screenMaxY +100, "→"));
  }
  
  void addScreen(Screen screen) {
    if (screens.containsKey(screen.getName())) {
      throw new RuntimeException("can't have duplicate screen names");
    }
    screens.put(screen.getName(), screen);
  }
  
  void addLine(String text) {
    curScreen.addLine(text);
  }
  
  void addLines(ArrayList<String> lines) {
    curScreen.addLines(lines);
  }
  
  void addLines(String[] lines) {
    curScreen.addLines(lines);
  }
  void newMainScreen(String name) {
    int maxLines = (int) Math.ceil((screenMaxY - screenMinY) / (strHeight + padding));
    Screen screen = new MainScreen(name, maxCharsPerLine, maxLines);
    addScreen(screen);
    print(maxLines);
  }
  
  void changeScreen(String name) {
    curScreen = screens.get(name);
    display();
  }
  
  void display() {
    fill(255);
    textFont(font);
    rect(screenMinX, screenMinY, screenMaxX, screenMaxY);
    curScreen.display(screenMinX, screenMaxX, screenMinY, screenMaxY, strHeight, padding);
    for (Button button : buttons) {
      button.display();
    }
  }
  
  void goUp() {
    curScreen.goUp();
  }
  
  void goDown() {
    curScreen.goDown();
  }
  
  void goLeft() {
    curScreen.goLeft();
  }
  
  void goRight() {
    curScreen.goRight();
  }
  
  
  void updateNewLine(char c) {
    curScreen.addToNewLine(c);
  }
  
  void submitNewLine() {
    curScreen.submitNewLine();
  }
}
