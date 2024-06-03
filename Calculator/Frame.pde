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
    buttonHeight = 35;
    buttonWidth = 35;

    newMainScreen("main");
    changeScreen("main");
    String[] test = {};
    addLines(test);
    
    addArrowButtons();
    addNumButtons();
    addOpButtons();
    equalsButton();
  }
  
  void equalsButton() {
    buttons.add(new MiscButton(buttonHeight, buttonWidth,  400, screenMaxY + 280, "="));
  }
  void addOpButtons() {
    buttons.add(new NumButton(buttonHeight, buttonWidth,  400, screenMaxY + 40, "+"));
    buttons.add(new NumButton(buttonHeight, buttonWidth,  400, screenMaxY + 100, "-"));
    buttons.add(new NumButton(buttonHeight, buttonWidth,  400, screenMaxY + 160, "/"));
    buttons.add(new NumButton(buttonHeight, buttonWidth,  400, screenMaxY + 220, "*"));
  }
  void addArrowButtons() {
    buttons.add(new NavButton(buttonHeight, buttonWidth,  10, screenMaxY + 100, "←"));
    buttons.add(new NavButton(buttonHeight, buttonWidth,  60, screenMaxY + 40, "↑"));
    buttons.add(new NavButton(buttonHeight, buttonWidth,  60, screenMaxY + 160, "↓"));
    buttons.add(new NavButton(buttonHeight, buttonWidth,  110, screenMaxY +100, "→"));
  }
  
  void addNumButtons() {
    buttons.add(new NumButton(buttonHeight, buttonWidth, 200, screenMaxY + 40, "1"));
    buttons.add(new NumButton(buttonHeight, buttonWidth, 260, screenMaxY + 40, "2"));
    buttons.add(new NumButton(buttonHeight, buttonWidth, 320, screenMaxY + 40, "3"));
    buttons.add(new NumButton(buttonHeight, buttonWidth, 200, screenMaxY + 100, "4"));
    buttons.add(new NumButton(buttonHeight, buttonWidth, 260, screenMaxY + 100, "5"));
    buttons.add(new NumButton(buttonHeight, buttonWidth, 320, screenMaxY + 100, "6"));
    buttons.add(new NumButton(buttonHeight, buttonWidth, 200, screenMaxY + 160, "7"));
    buttons.add(new NumButton(buttonHeight, buttonWidth, 260, screenMaxY + 160, "8"));
    buttons.add(new NumButton(buttonHeight, buttonWidth, 320, screenMaxY + 160, "9"));
    buttons.add(new NumButton(buttonHeight, buttonWidth, 260, screenMaxY + 220, "0"));
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
