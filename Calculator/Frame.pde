import java.util.Set;

class Frame {
  String[][] buttonLayout = {
  {"main","window","graphMenu","","graph"},
  {"","","x","↑",""},
  {"","","←","","→"},
  {"","","","↓","clear"},
  {"sin(","","","","^"},
  {"cos(","","(",")","/"},
  {"tan(","7","8","9","*"},
  {"csc(","4","5","6","-"},
  {"sec(","1","2","3","+"},
  {"cot(","0",".","","="},
  };
  
  Set<String> numButtons = Set.of(".","0","1","2","3","4","5","6","7","8","9","+","-","*","/","(",")","^","x","sin(","cos(","tan(","csc(","sec(","cot(");
  Set<String> navButtons = Set.of("↑","←", "→", "↓", "main", "window", "graphMenu", "graph");
  Set<String> miscButtons = Set.of("clear", "=");
  
  ArrayList<Button> buttons = new ArrayList<Button>();
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
    buttonWidth = 70;

    newMainScreen("main");
    newGraphMenu("graphMenu");
    newGraphWindow("window");
    changeScreen("main");
    //changeScreen("graphMenu");
    //changeScreen("window");
    String[] test = {};
    addLines(test);
    
    initializeButtons();
    //addArrowButtons();
    //addNumButtons();
    //addOpButtons();
    //equalsButton();
    //clearButton();
    //navButtons();
  }
  
  void initializeButtons() {
    float xSpacing = 90;
    float ySpacing = 50;
    String name;
    for (int i = 0; i < buttonLayout.length; i++) {
      for (int j = 0; j < buttonLayout[i].length; j++) {
        name = buttonLayout[i][j];
        if (name.equals("")) continue;
        if (numButtons.contains(name)) {
          buttons.add(new NumButton(buttonHeight, buttonWidth, 20 + xSpacing*j, screenMaxY + 20 + ySpacing*i, name));
        }
        else if (miscButtons.contains(name)) {
          buttons.add(new MiscButton(buttonHeight, buttonWidth, 20 + xSpacing*j, screenMaxY + 20 + ySpacing*i, name));
        }
        else if (navButtons.contains(name)) {
          buttons.add(new NavButton(buttonHeight, buttonWidth, 20 + xSpacing*j, screenMaxY + 20 + ySpacing*i, name));
        }
        
      }
    }
  }
  
  void newGraph() {
    Screen graphMenu = screens.get("graphMenu");
    Screen graphWindow = screens.get("window");
    Screen graph = new Graph("graph", screenMinX, screenMaxX, screenMinY, screenMaxY, graphWindow.getFields(), graphMenu.getEquations());
    addScreen(graph);
    
    
  }
  void addScreen(Screen screen) {
    //if (screens.containsKey(screen.getName())) {
    //  throw new RuntimeException("can't have duplicate screen names");
    //}
    screens.put(screen.getName(), screen);
  }
  
  void delete() {
    curScreen.delete();
  }
  void clearHistory() {
    curScreen.clearHistory();
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
    Screen screen = new MainScreen(name, maxCharsPerLine, maxLines, screenMinX, screenMaxX, screenMinY, screenMaxY, strHeight, padding, textWidth("a"));
    addScreen(screen);
    //print(maxLines);
  }
  
  void newGraphMenu(String name) {
    int maxEquations = 12;
    int maxLines = (int) Math.ceil((screenMaxY - screenMinY) / (strHeight + padding));
    Screen graphMenu = new GraphMenu(name, maxCharsPerLine, maxLines, screenMinX, screenMaxX, screenMinY, screenMaxY, strHeight, padding, textWidth("a"), maxEquations);
    addScreen(graphMenu);
    
  }
  
  void newGraphWindow(String name) {
    int maxLines = (int) Math.ceil((screenMaxY - screenMinY) / (strHeight + padding));
    Screen graphWindow = new GraphWindow(name, maxCharsPerLine, maxLines, screenMinX, screenMaxX, screenMinY, screenMaxY, strHeight, padding, textWidth("a"));
    addScreen(graphWindow);
  }
  void changeScreen(String name) {
    if (curScreen!=null&&curScreen.getName().equals("window")) {
      curScreen.submitNewLine();
    }
    curScreen = screens.get(name);
    display();
  }
  
  void display() {
    fill(255);
    textFont(font);
    
    if (curScreen.getName().equals("graph")) {
      
      noFill();
    }
    rect(screenMinX, screenMinY, screenMaxX, screenMaxY);
    curScreen.display();
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
