class Graph extends Screen {
  CalcMath calc;
  float gXmin;
  float gXmax;
  float gXscl;
  float gYmin;
  float gYmax;
  float gYscl;
  float gXres;
  float gdx;
  float gTraceStep;
  String[] equations;
  
  color[] colors= {
    color(0, 0, 255),
    color(255, 0, 0),
    color(0, 0, 0),
    color(255, 192, 203),
    color(0, 255, 0),
    color(255, 0, 255),
    color(255, 255, 0),
    color(51, 25, 0),
    color(50, 255, 255),
    color(255, 128, 0),
    color(255, 0, 127),
    color(128, 128, 128),
  };
  
  Graph(String name, float minX, float maxX, float minY, float maxY, LinkedHashMap<String, String> fields, String[] equations) {
    fill(255);
    rect(minX, minY, maxX, maxY);
    fill(0);
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
    this.equations = equations;
    calc = new CalcMath();
    display();
    graphEquations();
  }
  
  ArrayList<float[]> getPoints(String eq) {
    return null;
  }
  
  void graphEquations() {
    int count = 0;
    noStroke();
    for (String equation : equations) {
      if (equation.equals("")) continue;
      ArrayList<float[]> points = calc.graphPoints(equation, 'x', gXmin, gXmax, (gXmax - gXmin)/1000);
      
      fill(colors[count]);
      plotPoints(points);
      count++;
    }
    stroke(0);
    fill(0);
  }
  
  void display() {
    plotAxes();
    //float[][] sampleValues = {
    //        {-9.23f, 3.15f},
    //        {-7.88f, -1.45f},
    //        {-6.50f, 8.33f},
    //        {-3.14f, 0.56f},
    //        {-1.01f, -9.99f},
    //        {0.12f, -7.78f},
    //        {2.45f, 4.21f},
    //        {5.67f, -2.34f},
    //        {7.89f, 6.45f},
    //        {9.34f, -0.12f}
    //    };
        
    //ArrayList<float[]> points = new ArrayList<float[]>();
    //for (float[] point : sampleValues) {
    //  points.add(point);
    //}
    //plotPoints(points);
    //graphEquations();
    noFill();
  }
  
  void plotAxes () {
    float x = scaleX(0);
    fill(0);
    if (x >= minX && x <= maxX) {
      rect(x, minY, x+1, maxY);
    }
    float y = scaleY(0);
    if (y >= minY && y <= maxY) {
      rect(minX, y, maxX, y+1);
    }
    plotTicks();
  }
  
  void plotTicks() {
    float tick = gXscl;
    float x = scaleX(tick);
    while(x < maxX && 0 > gYmin && 0 < gYmax) {
      rect(x, scaleY(0) + 5, x+1, scaleY(0) - 4);
      tick += gXscl;
      x = scaleX(tick);
    }
    
    tick = -1 * gXscl;
    x = scaleX(tick);
    while(x > minX && 0 > gYmin && 0 < gYmax) {
      rect(x, scaleY(0) + 5, x+1, scaleY(0) - 4);
      tick -= gXscl;
      x = scaleX(tick);
    }
    
    tick = gYscl;
    float y = scaleY(tick);
    while(tick < gYmax && 0 > gXmin && 0 < gXmax) {
      rect(scaleX(0) + 5, y, scaleX(0)-4, y+1);
      tick += gYscl;
      y = scaleY(tick);
      //println(tick);
    }
    
    tick = -1 * gYscl;
    y = scaleY(tick);
    while(tick > gYmin && 0 > gXmin && 0 < gXmax) {
      rect(scaleX(0) + 5, y, scaleX(0)-4, y+1);
      tick -= gYscl;
      y = scaleY(tick);
    }
  }
  void plotPoints(ArrayList<float[]> points) {
    float[] last = null;
    for (float[] point : points) {
      if (point.length < 2) continue;
      float x = point[0];
      float y = point[1];
      
      if (x < gXmin || x > gXmax || y < gYmin || y > gYmax) continue;
      
      x = scaleX(x);
      y = scaleY(y);
      //fill(0);
      rect(x-1, y-1, x+1, y+1);
      if (last == null) {
        last = new float[]{x, y};
        continue;
      }
      
      line(last[0], last[1], x, y);
      last = new float[]{x,y};
      
      //text(Arrays.toString(point), x, y);
    }
  }
  
  float scaleX(float x) {
    return minX + (maxX - minX)/(gXmax - gXmin) * (x-gXmin);
  }
  float scaleY(float y) {
    return maxY - (maxY - minY)/(gYmax - gYmin) * (y-gYmin);
  }
}
