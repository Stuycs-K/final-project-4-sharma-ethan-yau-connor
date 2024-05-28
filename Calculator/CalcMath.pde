public class CalcMath{
  char[] basicopers = {'+', '-', '*', '/', '%', '^'};
  public CalcMath(){
  }
 public float basicOper(String str){
   ArrayList<String> splitted = new ArrayList<String>(); 
  for(int i = 0; i < str.length(); i++){
    int n=0;
    for(char c : basicopers){
      if(c == str.charAt(i)){
      splitted.add(str.substring(n,i));
      splitted.add(str.substring(i,i+1));
      n = i+1;
      }
    }
  }
  return(perform(splitted.get(1).charAt(0),Float.parseFloat(splitted.get(0)),Float.parseFloat(splitted.get(2))));
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
