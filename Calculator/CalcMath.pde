
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
  
  public void parenthesisCheck(ArrayList<String> split){
    int p1, p2;
    for(int i = 0; i < split.size(); i++){
      if(split.get(i).includes("(")){
        p1 = i;
      }
    }
    for(int i = split.size()-1; i > 0; i--){
      if(split.get(i).includes(")")){
        p2 = i;
      }
    }
    compute(split, p1, p2);
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
