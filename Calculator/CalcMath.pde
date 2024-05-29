
public class CalcMath{
  char[] basicopers = {'+', '-', '*', '/', '%', '^'};
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
  return splitted;
  }
  public float compute(String str){
    ArrayList<String> split = parseinp(str);
    for(int i = 0; i < split.size(); i++){
      for(char c: basicopers){
         if(c == split.get(i).charAt(0)){
           return basicOper(split, i);
         }
      }
    }
    return 0;
  }
 public float basicOper(ArrayList<String> split, int index){
  return(perform(split.get(index).charAt(0),Float.parseFloat(split.get(index-1)),Float.parseFloat(split.get(index+1))));
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
