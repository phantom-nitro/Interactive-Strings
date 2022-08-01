class Strin{
  PVector p1, p2, m, cm;
  float x1, x2, y1, y2, x, y;
  float size = 20;
  float delta = 0.02;
  float force, displacement;
  float k = 0.3;
  float velocity = 0;
  int state = 0;
  color c = #000000;
  float col;

  
  
  Strin(float x1, float y1, float x2, float y2){
    this.p1 = new PVector(x1, y1);
    this.p2 = new PVector(x2, y2);
    this.m = new PVector((x1 + x2) / 2, (y1 + y2) / 2);
    this.cm = new PVector((x1 + x2) / 2,(y1 + y2) / 2);
  }
  
  void draw(){

   stroke(c);
   strokeWeight(2);
   noFill();
   
   beginShape();
   for(float t = 0; t < 1; t += delta){
     x1 = lerp(p1.x, m.x, t);
     y1 = lerp(p1.y, m.y, t);
     x2 = lerp(m.x, p2.x, t);
     y2 = lerp(m.y, p2.y, t);
     x = lerp(x1, x2, t);
     y = lerp(y1, y2, t);
     vertex(x, y);

   }
   endShape();
   noStroke();  
  }
  void update(){
    if (state == 1){
      displacement = m.x - cm.x;
      
      force = -k * displacement;
      //F = A
      velocity += force;
      this.m.x += velocity;
      velocity *= 0.78; //0.98
      
      col = map(velocity, -200, 200, 1, 4);
      
      if((col < 1)) c = #4900ff; //#01FA58
      else if(col > 2.5) c = #9600ff; //#005668
      else if(col < 2.5) c = #00b8ff; //#2BBEBE;
      if(random(1)> 0.95)  c =  #ff00c1;
      if(col == 2.5) c = #4520fb; //#1E25B6;
      
      if((velocity < 0.01) && (velocity >= 0)){
          m.x = cm.x;
          velocity *= 0.01;
          c = #000000;

      }
      
      if((mouseX > cm.x - 30) && (mouseX < cm.x + 30) && (mouseY > p1.y) && (mouseY < p2.y)){
        state = 2;
      }
    }
    if(state == 0){
      if((mouseX > cm.x - 10) && (mouseX < cm.x + 10) && (mouseY > p1.y) && (mouseY < p2.y)){
        state = 2;
      }      
    }
    
    if(state == 2){
      c =     #d600ff;
      m.x = mouseX;
      //m.x = constrain(m.x, cm.x - 300, cm.x + 300);
      if((mouseX > cm.x + width/5) || (mouseX < cm.x - width/5)){
        state = 1;
      }
    }
  }
}

int count = 30;
Strin[] s = new Strin[count];

Strin s1;
Strin s2;
Strin s3;
int f = 0;

void setup(){
 size(1000, 1000); 
 background(250);
 frameRate(30);
 noStroke();
 
 int space = (width/2) / count;
 int sp = 1;
 for(int i = 0; i < count; i++){
   s[i] = new Strin(space*i + (width/2/2) , height/2 - 250 + sp , space * i + (width/2/2), height/2 + 250 - sp);
   if(i < count * 0.5) sp += 5;
   else sp -= 5;
 }
 


 
}

void draw(){
  background(250);
  fill(100);
  ellipse(mouseX, mouseY, 20, 20);

  for(int i = 0; i < s.length; i++){
    s[i].update();
    s[i].draw();
  }
  
  /*if(f++ < 900){
   saveFrame("line-######.png");
   println(f);
   }*/
  
}
