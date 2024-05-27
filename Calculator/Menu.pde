public class Menu extends Screen{
  public Menu(String name) {
    this.name = name;
    this.fontSize = 10;
    this.text = new ArrayList<String>();
    this.curLine = 0;
  }
  
  public Menu(String name, int fontSize) {
    this.name = name;
    this.fontSize = fontSize;
    this.text = new ArrayList<String>();
    this.curLine = 0;
  }
}
