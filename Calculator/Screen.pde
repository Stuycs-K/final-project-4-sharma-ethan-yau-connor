public abstract class Screen {
  String name;
  float[][] screenPixels;
  int screenHeight;
  int screenWidth;
  
  public Screen(String name, int screenHeight, int screenWidth) {
    this.name = name;
    this.screenHeight = screenHeight;
    this.screenWidth = screenWidth;
    this.pixels = new float[screenWidth][screenHeight];
  }
}
