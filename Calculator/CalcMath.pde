public class CalcMath{
  char[] basicOpers = {'^', '*', '/', '%', '+', '-'};
  char[][] opersOrdered = {{'^'}, {'*', '/', '%'}, {'+', '-'}};
  ArrayList<Integer> starts = new ArrayList<Integer>();
  ArrayList<Integer> ends = new ArrayList<Integer>();
  int ind = -1;
  public CalcMath(){
  }
  public ArrayList<String> parseinp(String str){
    ArrayList<String> splitted = new ArrayList<String>(); 
   int n=0;
  for(int i = 0; i < str.length(); i++){
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
  //println(splitted);
  return splitted;
  }
  public String compute(String str){
    ArrayList<String> split = parseinp(str);
    return compute(str,0,split.size());
  }
  public String compute(String str, int start, int end){
    ArrayList<String> split = parseinp(str);
    return compute(start, end, split);
  }
  public String compute(int start, int end, ArrayList<String> split){
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
  public boolean contains(char[] arr, char c){
    boolean isIn = false;
    for(int j = 0; j < arr.length; j++){
       if(arr[j] == c){
         isIn = true;
       }
    }
    return isIn;
  }
  
  public void parenthesisCheck(ArrayList<String> split){
    ArrayList<Integer> opens = new ArrayList<Integer>();
    ArrayList<Integer> closed = new ArrayList<Integer>();
    int start = starts.get(ind);
    int end = ends.get(ind);
    //println(start);
    //println(end);
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
  //println(opens);
  //println(closed);
  if(size > 0){
      int open = opens.get(0);
      int close = closed.get(0);
      split.set(open, split.get(open).substring(1,split.get(open).length()));
      split.set(close, split.get(close).substring(0,split.get(close).length()-1));
      
      //print(open);
      //print(close);
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
}
