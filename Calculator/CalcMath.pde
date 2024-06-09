public class CalcMath{
  char[] basicOpers = {'^', '*', '/', '%', '+', '-'};
  String[] trigOpers = {"sin", "cos", "tan", "csc", "sec", "cot"};
  char[][] opersOrdered = {{'^'}, {'*', '/', '%'}, {'+', '-'}};
  ArrayList<Integer> starts = new ArrayList<Integer>();
  ArrayList<Integer> ends = new ArrayList<Integer>();
  int ind = -1;
  public CalcMath(){
  }

  public ArrayList<float[]> graphPoints(String str, char x, float minX, float maxX, float dx){
  ArrayList<float[]> points = new ArrayList<float[]>();
  ArrayList<String> equation;
  for(float k = minX; k < maxX; k+=dx){
    String temp = str;
    String newStr;
    for(int i = 0; i < temp.length(); i++){
      if(temp.charAt(i) == x){
        if(i == 0 || contains(basicOpers,temp.charAt(i-1)) || temp.charAt(i-1) == '('){
          newStr = temp.substring(0,i) + k + temp.substring(i+1,temp.length());
        }
        else{
          newStr = temp.substring(0,i) + "*" + k + temp.substring(i+1,temp.length());
        }
        temp = newStr;
      }
    }
    equation = parseEq(temp);
    //println(equation);
    try{
    points.add(new float[] {k, Float.parseFloat(compute(equation))});
    }
    catch(Exception e){
    print("Error");
    }
  }
  return points;
  }

  public ArrayList<String> parseEq(String str){
   ArrayList<String> splitted = new ArrayList<String>(); 
   int n=0;
   int parenCount = 0;
    for(int i = 0; i < str.length(); i++){
        for(String trig : trigOpers){
          if(i < str.length() - 3){
          if(str.substring(i,i+3).equals(trig)){
            int newindex;
            for(newindex = i; newindex < str.length(); newindex++){
              if(str.charAt(newindex) == '('){
                parenCount++;
              }
              if(str.charAt(newindex) == ')'){
                parenCount--;
              }
              if(newindex > i+3 && parenCount == 0){
              break;
              }
            }
            i = newindex;
          }
        }
      }
      if(i >= str.length()){
        break;
      }
      for(char c : basicOpers){
        if(c == str.charAt(i)){
          if(str.charAt(i) == '-'){
            if(i != 0 && (str.charAt(i-1) <= '9' && str.charAt(i-1) >= '0'))
            {
             splitted.add(str.substring(n,i));
            splitted.add(str.substring(i,i+1));
            n = i+1;
            }
          }
          else{
             splitted.add(str.substring(n,i));
            splitted.add(str.substring(i,i+1));
            n = i+1;
          }
        }
      }
    }
  splitted.add(str.substring(n,str.length()));
  println(splitted);
  return splitted;
  }
  
  public String compute(ArrayList<String> split){
    return compute(0,split.size(), split);
  }
  public String compute(String str){
    ArrayList<String> split = parseEq(str);
    return compute(str,0,split.size());
  }
  public String compute(String str, int start, int end){
    ArrayList<String> split = parseEq(str);
    return compute(start, end, split);
  }
  public String compute(int start, int end, ArrayList<String> split){
    evalTrig(split);
    ind++;
    starts.add(start);
    ends.add(end);
    parenthesisCheck(split);
    if(end > split.size()){
      end = split.size();
    }
    println(split);
    pemdas(split);
    if(split.size() > 1){
    return "Error";
    }
    if(split.size() == 0){
      //curScreen.text.add(text.get(text.size() - 1));
      //text.add(text.get(text.size() - 2));
    }
    float result;
    try{
    result = +Float.parseFloat(split.get(0));
    }
    catch(Exception e){
      return "Error";
    }
    return "" + result;
    
  }
  
  
  public void evalTrig(ArrayList<String> split){
  for(int i = 0; i < split.size(); i++){
    for(String trig : trigOpers){
      if(split.get(i).contains(trig)){
         split.set(i, computeTrig(trig, split.get(i)));
      }
    }
  }
}
  
  public String computeTrig(String oper, String call){
    String inp;
  if(call.charAt(call.length()-1) == ')'){
    inp = compute(call.substring(4,call.length()-1));
  }
  else{
    inp = compute(call.substring(4,call.length()));
  }
  try{
  if(oper.equals("sin")){
    return ""+(float)Math.sin(Double.parseDouble(inp));
  }
  if(oper.equals("cos")){
    return ""+(float)Math.cos(Double.parseDouble(inp));
  }
  if(oper.equals("tan")){
    return ""+(float)Math.tan(Double.parseDouble(inp));
  }
  if(oper.equals("csc")){
    return ""+ 1 / (float)Math.sin(Double.parseDouble(inp));
  }
  if(oper.equals("sec")){
    return ""+ 1 / (float)Math.cos(Double.parseDouble(inp));
  }
  if(oper.equals("cot")){
    return ""+ 1 / (float)Math.tan(Double.parseDouble(inp));
  }
  return ""+0;
  }
  catch(Exception e){
  return "Error";
  }
  }
  
  public void parenthesisCheck(ArrayList<String> split){
    ArrayList<Integer> opens = new ArrayList<Integer>();
    ArrayList<Integer> closed = new ArrayList<Integer>();
    int start = starts.get(ind);
    int end = ends.get(ind);
    int k = 0;
    for(int i = start; i < end; i++){
      if(split.get(i).contains("(")){
        opens.add(Integer.valueOf(i));
        k+=stringCount(split.get(i), '(');
      }
      if(split.get(i).contains(")")){
        k-= stringCount(split.get(i), ')');
        if(k == 0){
          closed.add(Integer.valueOf(i));
        }
      }
    }
   parenthesisEval(opens, closed, split);
  }
  public int stringCount(String str, char counted){
  int count = 0;
    for(int i = 0; i < str.length(); i++){
      if(str.charAt(i) == counted){
        count++;
      }
  }
  return count;
}
  public void parenthesisEval(ArrayList<Integer> opens, ArrayList<Integer> closed, ArrayList<String> split){
  // Assume length of opens, closed is the same (otherwise error)
  int size = opens.size();
  if(size == closed.size()){
    if(size > 0){
        int open = opens.get(0);
        int close = closed.get(0);
        split.set(open, split.get(open).substring(1,split.get(open).length()));
        split.set(close, split.get(close).substring(0,split.get(close).length()-1));
        compute(open, close+1,split);
        ends.remove(ind);
        starts.remove(ind);
        ind--;
        if(ends.get(ind) > split.size()){
          ends.set(ends.get(ind),split.size());
          }
        parenthesisCheck(split);
    }
  }
  }
 public String basicOper(ArrayList<String> split, int index){
   float a = 0, b = 0;
   try{
     a = Float.parseFloat(split.get(index-1));
     b = Float.parseFloat(split.get(index+1));
   }
   catch(Exception e){
     return "Error";
   }
  float res = perform(split.get(index).charAt(0),a,b);
  split.set(index-1,"" + res);
  split.remove(index);
  split.remove(index);
  println(split);
  return ""+res;
 }
 
 public void pemdas(ArrayList<String> split){
    int start = starts.get(ind);
    int end = ends.get(ind);
    for(char[] b : opersOrdered){
      for(int i = start; i < end; i++){
        if(split.get(i).length() > 0){
          char c = split.get(i).charAt(0);
          if(split.get(i).length() == 1){
              if(contains(b, c)){
                 basicOper(split, i);
                 i--;
                 for(int j = 0; j < ends.size(); j++){
                   ends.set(j,ends.get(j)-2);
                   end = ends.get(ind);
                 }
              }
          }
       }
    }
  }
 }
 private float perform(char oper, float a, float b){
 if(oper == '+'){
 return a + b;
 }
 if(oper == '-'){
 return a - b;
 }
 if(oper == '*'){
 return a * b;
 }
 if(oper == '/'){
 return a / b;
 }
 if(oper == '%'){
 return a % b;
 }
 if(oper == '^'){
 return (float)Math.pow(a,b);
 }
 return 0;
 }
 public boolean contains(char[] arr, char c){
    boolean isIn = false;
    for(int j = 0; j < arr.length; j++){
       if(arr[j] == c){
         isIn = true;
       }
    }
    return isIn;
  }
  public boolean contains(String str, char c){
    boolean isIn = false;
    for(int j = 0; j < str.length(); j++){
       if(str.charAt(j) == c){
         isIn = true;
       }
    }
    return isIn;
  }
}
