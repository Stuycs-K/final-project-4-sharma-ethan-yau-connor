class MainScreen extends Screen{
  CalcMath calc;
  String TAG = "tag";
  String newLine;
  String ans;
  
  MainScreen(String name, int maxCharsPerLine, int maxLines, float minX, float maxX, float minY, float maxY, float strHeight, float padding, float textWidth) {
    this.name = name;
    this.text = new ArrayList<String>();
    this.topLine = 0;
    curChar = 0;
    selectedChar = 0;
    this.maxCharsPerLine = maxCharsPerLine;
    this.curLine = 0;
    smallFontSize = 12;
    fontSize = 32;
    this.maxLines = maxLines;
    this.newLine = "";
    calc = new CalcMath();
    this.minX = minX;
    this.maxX = maxX;
    this.minY = minY;
    this.maxY = maxY;
    this.strHeight = strHeight;
    this.padding = padding;
    this.textWidth = textWidth;
    this.ans = "0";
    
  }
  
  void goUp() {
    if (curLine > 0) curLine--;
    if (curLine < topLine) topLine = curLine;
    curChar = 0;
    //println(curLine + " " + topLine);
  }
  
  void goDown() {
    if (curLine < text.size()) curLine++;
    curChar = 0;
    if (curLine > topLine + maxLines - 2) topLine++;
    //println(curLine + " " + topLine);
  }
  
  void goLeft() {
    // for editable line
    if (curLine == text.size()) {
      selectedChar = Math.max(0, selectedChar - 1);
      if (selectedChar == 0) {
        curChar = Math.max(0, curChar - 1);
      }
      return;
      
    }
    //else 
    if (curChar > 0) curChar--;
  }
  
  void clearHistory() {
    text = new ArrayList<String>();
    curLine = 0;
    curChar = 0;
    selectedChar = 0;
    newLine = "";
  }
  void goRight() {
    // for editable line
    if (curLine == text.size()) {
      selectedChar = Math.min(selectedChar + 1, maxCharsPerLine);
      selectedChar = Math.min(selectedChar, newLine.length());
      if (selectedChar == maxCharsPerLine) {
        curChar = Math.min(curChar + 1, newLine.length() - maxCharsPerLine);
      }
      return;
    }
    
    //else 
    String line = text.get(curLine);
    if (line.indexOf(TAG) == 0) {
      line = line.substring(TAG.length());
    }
    if (curChar + maxCharsPerLine < line.length()) curChar++;
  }
  
  void highlightCurLine(float x, float y, String line) {
    fill(20, 20, 100, 160);
    noStroke();
    rect(x-2, y-2, x + textWidth(line) + 2, y + strHeight + 2);
    fill(0);
    stroke(0);
  }
  
  void leftJustify(boolean highlight, String text, float curHeight) {

    float minX = this.minX + padding;
    float minY = curHeight;
    float maxX = this.maxX - padding;
    float maxY = curHeight + strHeight; 
    
    fill(0);
    if (highlight) {
      highlightCurLine(minX, minY, text);
    }
    text(text, minX, minY, maxX, maxY);
    fill(255);
  }
  
  void rightJustify(boolean highlight, String text, float curHeight) {
    fill(0);
    float minX = this.maxX - padding - textWidth(text) - 5;
    float maxX = this.maxX - padding;
    float minY = curHeight;
    float maxY = curHeight + strHeight;
    
    //print("minX: " + minX + " maxX: " + maxX);
    if (highlight) {
      highlightCurLine(minX, minY, text);
    }
    text(text, minX, minY, maxX, maxY);
    fill(255);
  }
  
  void dividingLine(float minX, float maxX, float y) {
    fill(0);
    textSize(smallFontSize);
    float w = textWidth(".");
    int numChars = (int) Math.floor((maxX - minX)/w);
    
    String line = "";
    for (int i = 0; i < numChars; i++) {
      line += ".";
    }
    
    text(line, minX, y + 2);
    textSize(fontSize);
    fill(255);
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
  
  void leftOverFlow(float minX, float curHeight) {
    textSize(smallFontSize);
    text("◀", minX, curHeight + strHeight-10);
    textSize(fontSize);
  }
  
  void rightOverFlow(float maxX, float curHeight) {
    textSize(smallFontSize);
    text("▶", maxX - textWidth("▶"), curHeight + strHeight-10);
    textSize(fontSize);
    
  }
  
  void addToNewLine(char c) {
    int charToUpdate = curChar + selectedChar;

    if (curLine == text.size()) {
      if (charToUpdate == newLine.length()) {
        newLine += c;
      }else newLine = newLine.substring(0, charToUpdate) + c + newLine.substring(charToUpdate+1);
      

      
      selectedChar = Math.min(maxCharsPerLine, selectedChar+1);
      if (selectedChar == maxCharsPerLine) {
        curChar = Math.max(0, newLine.length() - maxCharsPerLine);
      }
            
      
      //println(selectedChar);
    }

  }
  
  void delete() {
    int charToUpdate = curChar + selectedChar;
    if (curLine == text.size()) {
      if (charToUpdate != newLine.length()) {
        newLine = newLine.substring(0, charToUpdate) + newLine.substring(charToUpdate+1);
      }
            
      
      //println(selectedChar);
    }
  }
  
  void submitNewLine() {
    if (curLine != text.size()) {
      String tex = text.get(curLine);
      if (tex.indexOf(TAG) == 0) {
        tex = tex.substring(TAG.length());
        
      }
      while (curLine != text.size()) {
        goDown();
      }
      
      for (int i = 0; i < tex.length(); i++) {
        addToNewLine(tex.charAt(i));
        //addToNewLine('a');
      }
      
      return;
    }
    if (newLine.length() == 0) {
      if (text.size() == 0) {
        return;
      }
      newLine = text.get(text.size()-2);
    }
    
    String calcLine = newLine;
    while (calcLine.indexOf("Ans") != -1) {
      int i = calcLine.indexOf("Ans");
      if (i+3 > calcLine.length()) {
        calcLine = calcLine.substring(0, i) + ans;
        return;
      }
      calcLine = calcLine.substring(0, i) + ans + calcLine.substring(i+3);
      
    }
    text.add(newLine);
    String result = calc.compute(calcLine);
    ans = result;
    text.add("tag" + result);
    newLine = "";
    curChar = 0;
    selectedChar = 0;
    goDown();
    goDown();
  }
  
  void display() {
    int count = 1;
    float curHeight = minY + padding;
    while (count < maxLines && (topLine + count - 1) <= text.size()-1) {
      //println(count + " " + maxLines);
      fill(0);
      //print(text.get(topLine + count - 1));
      String line = text.get(topLine + count - 1);
      
      boolean rightJustify = false;
      if (line.indexOf(TAG) == 0) {
        rightJustify = true;
        line = line.substring(TAG.length());
      }
      
      if (line.length() > maxCharsPerLine) {
        boolean leftOverFlow = false;
        boolean rightOverFlow = false;
        
        if (line.length() > curChar + maxCharsPerLine) {
          rightOverFlow = true;
        }
        if (curChar > 0) {
          leftOverFlow = true;
        }
        int startChar = 0;
        if (curLine == topLine + count - 1) {
          startChar = curChar;  
        }
        line = line.substring(startChar, startChar + maxCharsPerLine);
        if (leftOverFlow) {
          leftOverFlow(minX, curHeight);
        }
        if (rightOverFlow) {
          rightOverFlow(maxX, curHeight);
        }
      }
      
      boolean highlight = false;
      // highlight selected line
      //println(topLine + " " + count + " " + curLine + " ");
      if (topLine + count - 1 == curLine) highlight = true; 
      
      if (rightJustify) {
        rightJustify(highlight, line, curHeight);
        //print("rightJustify");
        dividingLine(minX + padding, maxX - padding, curHeight + strHeight + 3);
      } else {
        leftJustify(highlight, line, curHeight);
      }
      
      
      curHeight += padding + strHeight;
      rightJustify = false;
      highlight = false;
      fill(255);
      count++;
    }
    
    String line = newLine;

    if (line.length() > maxCharsPerLine) {
        boolean leftOverFlow = false;
        boolean rightOverFlow = false;
        
        if (line.length() > curChar + maxCharsPerLine) {
          rightOverFlow = true;
        }
        if (curChar > 0) {
          leftOverFlow = true;
        }
        
        line = line.substring(curChar, curChar + maxCharsPerLine);
        
        if (leftOverFlow) {
          leftOverFlow(minX, curHeight);
        }
        if (rightOverFlow) {
          rightOverFlow(maxX, curHeight);
        }
      }
    
    if (curLine == text.size()) {
      float x;
      x = minX + padding + Math.min(selectedChar * textWidth("a"),textWidth(line));
      blinkBox(x, curHeight);
    }
    leftJustify(false, line, curHeight);
    
    
  }
  
}
