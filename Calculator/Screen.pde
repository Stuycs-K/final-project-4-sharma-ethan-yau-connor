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
  String TAG = "tag";
  String newLine;
  float minX;
  float maxX;
  float minY;
  float maxY;
  float strHeight;
  float padding;
  float textWidth;
  
  String getName() {
    return name;
  }
  
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
    for (String line: lines) {
      text.add(line);
    }
  }
  
  void addToNewLine(char c) {
    if (curLine == text.size()) {
      newLine += c;
    }
    
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
