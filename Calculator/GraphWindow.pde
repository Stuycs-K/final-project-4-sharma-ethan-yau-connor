import java.util.LinkedHashMap;

class GraphWindow extends Screen {
  LinkedHashMap<String, String> fields = new LinkedHashMap<String, String>();
  LinkedHashMap<String, String> lastFields;
  int leftMostChar;
  String curKey;
  int prefixLength;
  
  GraphWindow(String name, int maxCharsPerLine, int maxLines, float minX, float maxX, float minY, float maxY, float strHeight, float padding, float textWidth) {
    this.name = name;
    this.text = new ArrayList<String>();
    this.topLine = 0;
    curChar = 0;
    leftMostChar = 0;
    selectedChar = 0;
    this.maxCharsPerLine = maxCharsPerLine;
    this.curLine = 0;
    smallFontSize = 12;
    fontSize = 32;
    this.maxLines = maxLines;
    this.newLine = "";
    this.minX = minX;
    this.maxX = maxX;
    this.minY = minY;
    this.maxY = maxY;
    this.strHeight = strHeight;
    this.padding = padding;
    this.textWidth = textWidth;
    initializeFields();
  }
  
  void addToNewLine(char c) {
    String text = fields.get(curKey);
    String val;
    if (selectedChar == text.length()) {
      val = fields.get(curKey) + c;
    }
    else {
      val = text.substring(0, selectedChar) + c + text.substring(selectedChar+1);
    }
    
    fields.put(curKey, val);
    goRight();
  } 
  
  void initializeFields() {
    String[] fieldsNames = {"Xmin", "Xmax", "Xscl", "Ymin", "Ymax", "Yscl", "Xres", "ΔX", "TraceStep"};
    //Xmin Xmax Ymin Ymax self explanatory
    //Xscl Yscl determines where ticks are
    
    String[] fieldValues = {"-10", "10", "1", "-10", "10", "1", "1", "0.075757575757576", "0.15151515151515"};
    
    for (int i = 0; i < fieldsNames.length; i++) {
      fields.put(fieldsNames[i], fieldValues[i]);
    }
    
    lastFields = new LinkedHashMap<String, String>(fields);
  }
  
  LinkedHashMap<String, String> getFields() {
    return fields;
  }
  
  void submitNewLine() {
    submitNewLine(true);
  }
  void submitNewLine(boolean goDown) {
    boolean notValid = false;
    notValid = notValid || !isFloat(fields.get(curKey));
    if (fields.get(curKey).equals("")) {
      fields.put(curKey, lastFields.get(curKey));
    }
    notValid = notValid || Float.valueOf(fields.get("Xmin")) >= Float.valueOf(fields.get("Xmax"));
    notValid = notValid || Float.valueOf(fields.get("Ymin")) >= Float.valueOf(fields.get("Ymax"));
    
    
    
    if (notValid) {
      fields.put(curKey, lastFields.get(curKey));
    } else {
      lastFields.put(curKey, fields.get(curKey));
      
    }
    if (goDown) {
      goDown();
    }
  }
  
  void clearHistory() {
    fields.put(curKey, "");
    curChar = 0;
    selectedChar = 0;
    leftMostChar = 0;
  }
  
  boolean isFloat(String str) {
    return str.matches("[-+]?[0-9]*\\.?[0-9]+");
  }
  
  void delete() {
    String line = fields.get(curKey);
    if (curLine == text.size()) {
      if (selectedChar != line.length()) {
        fields.put(curKey, line.substring(0, selectedChar) + line.substring(selectedChar+1));
      }
            
      
      //println(selectedChar);
    }
  }
  
  void display() {
    leftJustify("WINDOW", minY + padding);
    float curHeight = minY + padding + strHeight;
    
    int count = 0;
    for (String k : fields.keySet()) {
      float offset = curChar * textWidth;
      String prefix = " " + k + "=";
      
      float prefixOffset = textWidth(" " + k + "=");
      int startChar = 0;
      if (count == curLine) {
        blinkBox(minX + prefixOffset + offset + padding, curHeight);
        curKey = k;
        startChar = leftMostChar;
        prefixLength = prefix.length();
      }
      
      
      String text = prefix + fields.get(k).substring(startChar);
      leftJustify(text, curHeight);
      
      
      
      
      
      
      
      curHeight += strHeight;
      count++;
    }
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
    submitNewLine(false);
  }
  
  void goDown() {

    if (curLine < maxLines - 1) curLine++;
    else if (topLine + curLine < maxLines - 1) topLine++;
    curChar = 0;
    leftMostChar = 0;
    selectedChar = 0;
    //println(curLine + " " + topLine);
    submitNewLine(false);
  }
  void goRight(){
    int maxChars;
    String value = fields.get(curKey);
    maxChars = value.length();
    println(prefixLength);
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
}
