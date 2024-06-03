class MainScreen extends Screen{
  
  MainScreen(String name, int maxCharsPerLine, int maxLines) {
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
  
  void highlightCurLine(float textWidth, float x, float y, float strHeight, float padding) {
    fill(20, 20, 100, 160);
    noStroke();
    rect(x-2, y-2, x + textWidth + 2, y + strHeight + 2);
    fill(0);
    stroke(0);
  }
  
  void leftJustify(boolean highlight, String text, float minX, float minY, float maxX, float maxY, float strHeight) {
    fill(0);
    if (highlight) {
      highlightCurLine(textWidth(text), minX, minY, strHeight, textWidth(text));
    }
    text(text, minX, minY, maxX, maxY);
    fill(255);
  }
  
  void rightJustify(boolean highlight, String text, float minX, float minY, float maxX, float maxY, float strHeight) {
    fill(0);
    minX = maxX - textWidth(text) - 5;
    
    //print("minX: " + minX + " maxX: " + maxX);
    if (highlight) {
      highlightCurLine(textWidth(text), minX, minY, strHeight, textWidth(text));
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
  
  void blinkBox(float minX, float minY, float strHeight) {
    int speed = 30;
    float w = textWidth(".");
    stroke(255);
    if ((frameCount / speed) % 2 == 0) {
      fill(0);
    } else {
      fill(255);
    }
    rect(minX, minY, minX + w, minY + strHeight);
    
    fill(255);
    stroke(0);
  }
  
  void leftOverFlow(float minX, float padding, float curHeight, float strHeight) {
    textSize(smallFontSize);
    text("◀", minX, curHeight + strHeight-10);
    textSize(fontSize);
  }
  
  void rightOverFlow(float maxX, float padding, float curHeight, float strHeight) {
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
    }
      curChar = Math.max(0, newLine.length() - maxCharsPerLine);
      selectedChar = Math.min(maxCharsPerLine, selectedChar+1);
      
      println(selectedChar);
  }
  
  void submitNewLine() {
    if (curLine == text.size()) {
      text.add(newLine);
      goDown();
      newLine = "";
      curChar = 0;
      selectedChar = 0;
    }
  }
  
  void display(float minX, float maxX, float minY, float maxY, float strHeight, float padding) {
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
          leftOverFlow(minX, padding, curHeight, strHeight);
        }
        if (rightOverFlow) {
          rightOverFlow(maxX, padding, curHeight, strHeight);
        }
      }
      
      boolean highlight = false;
      // highlight selected line
      //println(topLine + " " + count + " " + curLine + " ");
      if (topLine + count - 1 == curLine) highlight = true; 
      
      if (rightJustify) {
        rightJustify(highlight, line, minX + padding, curHeight, maxX - padding, curHeight + strHeight, strHeight);
        //print("rightJustify");
        dividingLine(minX + padding, maxX - padding, curHeight + strHeight + 3);
      } else {
        leftJustify(highlight, line, minX + padding, curHeight, maxX - padding, curHeight + strHeight, strHeight);
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
          leftOverFlow(minX, padding, curHeight, strHeight);
        }
        if (rightOverFlow) {
          rightOverFlow(maxX, padding, curHeight, strHeight);
        }
      }
    
    if (curLine == text.size()) {
      float x;
      x = minX + padding + Math.min(selectedChar * textWidth("a"),textWidth(line));
      blinkBox(x, curHeight, strHeight);
    }
    leftJustify(false, line, minX + padding, curHeight, maxX - padding, curHeight + strHeight, strHeight);
    
    
  }
  
}
