# SG-Android

# 1주차과제

![image](https://github.com/user-attachments/assets/031fccaf-3a61-409d-98ba-824c0935b08e)

![image](https://github.com/user-attachments/assets/28316b64-4819-4532-b546-4f2a49537892)



void main() {
  var n = 10;
  var result = '';  
  for(var x = 0; x < n; x++){
    for(var y = 0; y < n; y++){
      var c = f1(x, y, n) || f2(x,y,n);
      if (c){
        result += '=';  
      }
      else{
        result += ' ';
      }
    }  
    result += '\n';
  }
  print(result);
}
bool f1(int x, int y, int size){
  return x == 0 
    || y == 0 
    || x == size - 1
    || y == size - 1;
}
bool f2(int x, int y, int size) {
  return x == 0 
    || y == 0 
    || x == size - 1 
    || y == size - 1 
    || x == y            
    || x + y == size - 1; 
}
