public class Menu extends Screen{
  
  public Menu(String name, int fontSize) {
    this.name = name;
    this.fontSize = fontSize;
    this.text = new ArrayList<String>();
    this.curLine = -1;
  }
  
  public Menu(String name) {
    this(name, 10);
  }
  
}
