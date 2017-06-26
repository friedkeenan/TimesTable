// I know I should make this into a class but I'm lazy
boolean redUp=random(1)>.5;
boolean blueUp=random(1)>.5;
boolean greenUp=random(1)>.5;
color changeColor(color c,float s){
  if(red(c)==255)
    redUp=false;
  if(red(c)==0)
    redUp=true;
  if(green(c)==255)
    greenUp=false;
  if(green(c)==0)
    greenUp=true;
  if(blue(c)==255)
    blueUp=false;
  if(blue(c)==0)
    blueUp=true;
  if(redUp){
    if(greenUp){
      if(blueUp){
        c=color(red(c)+s,green(c)+s,blue(c)+s,alpha(c));
      }else{
        c=color(red(c)+s,green(c)+s,blue(c)-s,alpha(c));
      }
    }else{
      if(blueUp){
        c=color(red(c)+s,green(c)-s,blue(c)+s,alpha(c));
      }else{
        c=color(red(c)+s,green(c)-s,blue(c)-s,alpha(c));
      }
    }
  }else{
    if(greenUp){
      if(blueUp){
        c=color(red(c)-s,green(c)+s,blue(c)+s,alpha(c));
      }else{
        c=color(red(c)-s,green(c)+s,blue(c)-s,alpha(c));
      }
    }else{
      if(blueUp){
        c=color(red(c)-s,green(c)-s,blue(c)+s,alpha(c));
      }else{
        c=color(red(c)-s,green(c)-s,blue(c)-s,alpha(c));
      }
    }
  }
  return c;
}