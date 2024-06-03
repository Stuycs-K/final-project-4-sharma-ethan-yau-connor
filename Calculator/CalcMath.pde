public class CalcMath{
  char[] basicopers = {'^', '*', '/', '%', '+', '-'};
  ArrayList<Integer> starts = new ArrayList<Integer>();
  ArrayList<Integer> ends = new ArrayList<Integer>();
  int ind = -1;
  public CalcMath(){
  }
  public ArrayList<String> parseinp(String str){
    ArrayList<String> splitted = new ArrayList<String>(); 
   int n=0;
  for(int i = 0; i < str.length(); i++){
    for(char c : basicopers){
      if(c == str.charAt(i)){
      splitted.add(str.substring(n,i));
      splitted.add(str.substring(i,i+1));
      n = i+1;
      }
    }
  }
  splitted.add(str.substring(n,str.length()));
  //println(splitted);
  return splitted;
  }
  public float compute(String str){
    ArrayList<String> split = parseinp(str);
    return compute(str,0,split.size());
  }
  public float compute(String str, int start, int end){
    ArrayList<String> split = parseinp(str);
    return compute(start, end, split);
  }
  public float compute(int start, int end, ArrayList<String> split){
    ind++;
    starts.add(start);
    ends.add(end);
    parenthesisCheck(split);
    if(end > split.size()){
      end = split.size();
    }
    for(char c: basicopers){
      for(int i = starts.get(ind); i < ends.get(ind); i++){
        //println(i);
        if(c == split.get(i).charAt(0) && split.get(i).length() == 1){
           basicOper(split, i);
           i--;
           for(int j = 0; j < ends.size(); j++){
             ends.set(j,ends.get(j)-2);
           }      
         }
      }
    }
    
    return Float.parseFloat(split.get(0));
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
  //println(opens);
  //println(closed);
  if(size > 0){
      int open = opens.get(0);
      int close = closed.get(0);
      split.set(open, split.get(open).substring(1,split.get(open).length()));
      split.set(close, split.get(close).substring(0,split.get(close).length()-1));
      //println(split);
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
 public float basicOper(ArrayList<String> split, int index){
  float res = perform(split.get(index).charAt(0),Float.parseFloat(split.get(index-1)),Float.parseFloat(split.get(index+1)));
  split.set(index-1,"" + res);
  split.remove(index);
  split.remove(index);
  //println(split);
  return res;
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
 return (float)a / b;
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
