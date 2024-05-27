public class Screen {
  String name;
  float[][] screenPixels;
  int screenHeight;
  int screenWidth;
  
  public Screen(String name, int screenHeight, int screenWidth) {
    this.name = name;
    this.screenHeight = screenHeight;
    this.screenWidth = screenWidth;
    fill(255);
    rect(10,10,screenWidth, screenHeight);
    mousexpos = 10;
    mouseypos = 32 + 10;
    //this.pixels = new float[screenWidth][screenHeight];
  }
}
