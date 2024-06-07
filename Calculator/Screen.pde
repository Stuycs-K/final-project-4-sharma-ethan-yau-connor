import java.util.*;

abstract class Screen {
  String name;
  ArrayList<String> text;
  int topLine;
  int curLine;
  int maxCharsPerLine;
  int curChar;
  int fontSize;
  int smallFontSize;
  int maxLines;
  int selectedChar;
  float minX;
  float maxX;
  float minY;
  float maxY;
  float strHeight;
  float padding;
  float textWidth;
  String newLine;
  
  String getName() {
    return name;
  }
  
  void graphEquations() {}
  LinkedHashMap<String,String> getFields() {return null;}
  String[] getEquations() {return null;}
  void addLine(String line){
    text.add(line);
    topLine++;
  }
  
  void addLines(ArrayList<String> lines) {
    for (String line: lines) {
      text.add(line);
    }
  }
  
  void addLines(String[] lines) {
    print("ABCD");
    for (String line: lines) {
      text.add(line);
    }
  }
  
  void addToNewLine(char c) {
    if (curLine == text.size()) {
      newLine += c;
    }
    
  }
  void leftJustify(String text, float curHeight) {

    float minX = this.minX + padding;
    float minY = curHeight;
    float maxX = this.maxX - padding;
    float maxY = curHeight + strHeight; 
    
    fill(0);
    text(text, minX, minY, maxX, maxY);
    fill(255);
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
