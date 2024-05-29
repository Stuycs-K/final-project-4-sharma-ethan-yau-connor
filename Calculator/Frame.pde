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
  
  Frame(float screenMinX, float screenMinY, float screenHeight) {
    buttons = new ArrayList<Button>();
    screens = new HashMap<String, Screen>();
    font = createFont("Monospaced", 16);
    strAscent = textAscent();
    strDescent = textDescent();
    strHeight = strAscent + strDescent;
    this.screenMinX = screenMinX;
    this.screenMinY = screenMinY;
    screenMaxX = width - screenMinX;
    screenMaxY = screenMinY + screenHeight;
    padding = 10;
    
    newMenu("menu");
    changeScreen("menu");
  }
  
  void addScreen(Screen screen) {
    if (screens.containsKey(screen.getName())) {
      throw new RuntimeException("can't have duplicate screen names");
    }
    screens.put(screen.getName(), screen);
  }
  
  void newMenu(String name) {
    Screen screen = new Menu(name);
    addScreen(screen);
  }
  
  void changeScreen(String name) {
    curScreen = screens.get(name);
    display();
  }
  
  void display() {
    textFont(font);
    rect(screenMinX, screenMinY, screenMaxX, screenMaxY);
    curScreen.display(screenMinX, screenMaxX, screenMinY, screenMaxY, strHeight, padding);
  }
  
  void goUp() {
    curScreen.goUp();
  }
  
  void goDown() {
    curScreen.goDown();
  }
  
}
