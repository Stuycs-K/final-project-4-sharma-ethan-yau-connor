
public class CalcMath{
  char[] basicopers = {'^', '*', '/', '%', '+', '-'};
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
  println(splitted);
  return splitted;
  }
  public float compute(String str){
    return compute(str,0,str.length());
  }
  public float compute(String str, int start, int end){
    ArrayList<String> split = parseinp(str);
    if(end > split.size()-1){
       return compute(start, split.size(), split);
    }
    return compute(start, end, split);
  }
  public float compute(int start, int end, ArrayList<String> split){
    parenthesisCheck(start, end, split);
    for(char c: basicopers){
      for(int i = start; i < end; i++){
        if(c == split.get(i).charAt(0)){
           basicOper(split, i);
           i--;
         }
      }
    }
    return Float.parseFloat(split.get(0));
  }
  
  public void parenthesisCheck(int start, int end, ArrayList<String> split){
    ArrayList<Integer> opens = new ArrayList<Integer>();
    ArrayList<Integer> closed = new ArrayList<Integer>();
    print(end);
    for(int i = start; i < end; i++){
      if(split.get(i).contains("(")){
        opens.add(Integer.valueOf(i));
      }
      if(split.get(i).contains(")")){
        closed.add(Integer.valueOf(i));
      }
    }
   parenthesisEval(opens, closed, split);
  }
  public void parenthesisEval(ArrayList<Integer> opens, ArrayList<Integer> closed, ArrayList<String> split){
  // Assume length of opens, closed is the same (otherwise error)
  int size = opens.size();
  if(size > 0){
    for(int i = 0; i < size; i++){
      int open = opens.get(i);
      int close = closed.get(size - i - 1);
      split.set(open, split.get(open).substring(1,split.get(open).length()));
      split.set(close, split.get(close).substring(0,split.get(open).length()-1));
      compute(open, close,split);
    }
  }
  }
 public float basicOper(ArrayList<String> split, int index){
  float res = perform(split.get(index).charAt(0),Float.parseFloat(split.get(index-1)),Float.parseFloat(split.get(index+1)));
  split.set(index-1,"" + res);
  split.remove(index);
  split.remove(index);
  println(split);
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
