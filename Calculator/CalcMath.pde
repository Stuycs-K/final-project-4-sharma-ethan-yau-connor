
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
    ArrayList<String> split = parseinp(str);
    for(char c: basicopers){
      for(int i = 0; i < split.size(); i++){
        if(c == split.get(i).charAt(0)){
           basicOper(split, i);
         }
    }
    }
    return Float.parseFloat(split.get(0));
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
