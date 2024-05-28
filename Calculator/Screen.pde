public abstract class Screen {
  String name;
  ArrayList<String> text;
  int fontSize;
  int curLine;
  
  public String getName() {
    return name;
  }
  
  public void addLine(String line){
    text.add(line);
    curLine++;
  }
  
  public void display(float minX, float maxX, float minY, float maxY, float strAscent) {
    int count = 1;
    while (count*strAscent < maxY - minY) {
      text(text.get(curLine + count-1), minX, 
                              minY + count*strAscent, 
                              maxX, 
                              minY + (count+1)*strAscent);
      count++;
    }
  }
  
}
