class Graph extends Screen {
  
  float gXmin;
  float gXmax;
  float gXscl;
  float gYmin;
  float gYmax;
  float gYscl;
  float gXres;
  float gdx;
  float gTraceStep;
  
  Graph(String name, float minX, float maxX, float minY, float maxY, LinkedHashMap<String, String> fields) {
    this.name = name;
    this.minX = minX;
    this.maxX = maxX;
    this.minY = minY;
    this.maxY = maxY;
    gXmin = Float.parseFloat(fields.get("Xmin"));
    gXmax = Float.parseFloat(fields.get("Xmax"));
    gXscl = Float.parseFloat(fields.get("Xscl"));
    gYmin = Float.parseFloat(fields.get("Ymin"));
    gYmax = Float.parseFloat(fields.get("Ymax"));
    gYscl = Float.parseFloat(fields.get("Yscl"));
    gXres = Float.parseFloat(fields.get("Xres"));
    gdx = Float.parseFloat(fields.get("ΔX"));
    gTraceStep = Float.parseFloat(fields.get("TraceStep"));
  }
  
  ArrayList<float[]> getPoints(String eq) {
    return null;
  }
  
  void display() {
  
  }
  
  void plotPoints(ArrayList<float[]> points) {
    for (float[] point : points) {
      if (point.length < 2) continue;
      float x = point[0];
      float y = point[1];
      
      if (x < gXmin || x > gXmax || y < gYmin || y > gYmax) continue;
      
      x = scaleX(x);
      y = scaleY(y);
      fill(255);
      rect(x, y, x+1, y+1);
    }
  }
  
  float scaleX(float x) {
    return (maxX - minX)/(gXmax - gXmin) * x;
  }
  float scaleY(float y) {
    return (maxY - minY)/(gYmax - gYmin) * y;
  }
}
