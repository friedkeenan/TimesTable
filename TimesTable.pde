import java.util.List;
import java.util.ArrayList;
/*
import gifAnimation.*; //Uncomment these lines, lines 64-72, and lines 133-136 to enable making a gif 
GifMaker gif;
*/
int radius=250; // Change this to change the size of the window
boolean newTable=true;
PVector newLoc;
int move=-1;
boolean makeGif=false;
class Times{
  PVector loc;
  color col,back;
  int num;
  float mult=1.0000000000000;
  float rad;
  boolean text=false;
  float textSize;
  Times(PVector loc_,int num_,float rad_,color col_){
    loc=loc_;
    num=num_;
    rad=rad_;
    col=col_;
    back=color(255-red(col),255-green(col),255-blue(col));
  }
  void draw(){
    fill(255);
    if(text){
      textSize(textSize);
      text(str(mult).substring(0,floor(log(mult)/log(10))+3),-rad+loc.x,-rad+loc.y+textSize);
      text(num,-rad+loc.x,-rad+loc.y+2*textSize);
    }
    fill(back);
    ellipse(loc.x,loc.y,rad*2,rad*2);
    back=changeColor(back,1);
    stroke(col);
    for(int i=0;i<num;i++){
      PVector orig=(new PVector(-cos(2*i*(float)Math.PI/num),sin(2*i*(float)Math.PI/num))).setMag(rad);
      PVector end=(new PVector(-cos(mult*2*i*(float)Math.PI/num),sin(mult*2*i*(float)Math.PI/num))).setMag(rad);
      line(orig.x+loc.x,orig.y+loc.y,end.x+loc.x,end.y+loc.y);
    }
    stroke(255);
    noFill();
    ellipse(loc.x,loc.y,rad*2,rad*2);
    col=changeColor(col,1);
    mult+=.1;
  }
  boolean collide(PVector p){
    return (pow((p.x-loc.x)/rad,2)+pow((p.y-loc.y)/rad,2)<=1);
  }
  void toggleText(){
    text=!text;
    textSize=.12*rad;
  }
}
List<Times> tables=new ArrayList<Times>();
void keyPressed(){
  if(key==' ')
    tables.clear();
  if(key=='r'){
    tables.clear();
    Times tab=new Times(new PVector(),int(random(150,300)),radius,color(random(256),random(256),random(256)));
    tab.toggleText();
    tables.add(tab);
    /*
    if(!makeGif){
      gif=new GifMaker(this,"table.gif");
      gif.setRepeat(0);
      gif.setDelay((int)(1000/frameRate));
    }else
      gif.finish();
    makeGif=!makeGif;
    */
  }
}
void mouseDragged(){
  if(move==-1){
    for(int i=0;i<tables.size();i++){
      if(tables.get(i).collide(new PVector(mouseX-width/2,mouseY-height/2)))
        move=i;
    }
  }else
    tables.get(move).loc=new PVector(mouseX-width/2,mouseY-height/2);
  newTable=true;
}
void mousePressed(){
  if(mouseButton==CENTER){
    int last=-1;
    for(int i=0;i<tables.size();i++){
      if(tables.get(i).collide(new PVector(mouseX-width/2,mouseY-height/2)))
        last=i;
    }
    if(last!=-1)
      tables.remove(last);
  }else if(mouseButton==LEFT){
    if(newTable)
      newLoc=new PVector(mouseX-width/2,mouseY-height/2);
    else{
      float r=sqrt(pow(mouseX-width/2-newLoc.x,2)+pow(mouseY-height/2-newLoc.y,2));
      Times tab=new Times(newLoc,int(random(150,300)),r,color(random(256),random(256),random(256)));
      tables.add(tab);
    }
    newTable=!newTable;
  }else if(mouseButton==RIGHT){
    int last=-1;
    for(int i=0;i<tables.size();i++){
      if(tables.get(i).collide(new PVector(mouseX-width/2,mouseY-height/2)))
        last=i;
    }
    if(last!=-1){
      tables.get(last).toggleText();
    }
  }
}
void settings(){
  size(100,100);
}
void setup(){
  surface.setSize(radius*2,radius*2);
  Times tab=new Times(new PVector(),int(random(150,300)),radius,color(random(256),random(256),random(256)));
  tab.toggleText();
  tables.add(tab);
}
void draw(){
  if(!mousePressed)
    move=-1;
  translate(width/2,height/2);
  background(0);
  for(Times t:tables)
    t.draw();
  /*
  if(makeGif)
    gif.addFrame();
  */
}
