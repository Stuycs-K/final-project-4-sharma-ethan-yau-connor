public class Frame {
  ArrayList<Button> buttons;
  Screen curScreen;
  HashMap<String, Screen> screens;
  float screenMinX;
  float screenMinY;
  float screenMaxX;
  float screenMaxY;
  PFont font;
  float strAscent;
  
  public Frame(float screenMinX, float screenMinY, float screenMaxX, float screenMaxY) {
    this.buttons = new ArrayList<Button>();
    this.screens = new HashMap<String, Screen>();
    this.font = createFont("Monospaced", 64);
    this.strAscent = textAscent();
    this.screenMinX = screenMinX;
    this.screenMinY = screenMinY;
    this.screenMaxX = screenMaxX;
    this.screenMaxY = screenMaxY;
  }
  
  public void addScreen(Screen screen) {
    if (screens.containsKey(screen.getName())) {
      throw new RuntimeException("can't have duplicate screen names");
    }
    screens.put(screen.getName(), screen);
  }
  
  public void changeScreen(String name) {
    curScreen = screens.get(name);
    display();
  }
  
  public void display() {
    curScreen.display(screenMinX, screenMaxX, screenMinY, screenMaxY, strAscent);
  }
  
  
}
