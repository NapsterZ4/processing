Ant[] ant = new Ant[10];
Stick[] stick = new Stick[25];
public int moveX = (int) random(-5,5);
public int moveY = (int) random(-5,5);
public int moveX_stick = (int) random(0, 1000);
public int moveY_stick = (int) random(0,1000);

public int minDistanceStick = 10;

class Stick{
  PVector position;
  boolean taken;
  
  Stick(int x, int y){
    position = new PVector(x,y,0);
    taken = false;
  }
  
  void displayStick(){
    fill(230,40,2);
    rect(position.x, position.y, 10,10);
  }
 }

class Ant{
  PVector position;
  boolean haveStick;
  
  Ant(int x, int y){
    position = new PVector(x,y,0);
    haveStick = false;
  }
  
  void displayAnt(){
    fill(0);
    point(position.x, position.y);
  }
  
  void move(){
    position.x += moveX;
    position.y += moveY;
  }
  
  //Logica para buscar el palito
  Stick distanceTakeStick(){
    
    Stick near = new Stick(-10, -10);
    for (int i=0; i < stick.length; ++i){
      double ac = Math.abs(position.y - stick[i].position.y);
      double cb = Math.abs(position.x - stick[i].position.x);
      double distanceStick = Math.hypot(ac, cb);
      
      if(distanceStick < minDistanceStick){
        near = stick[i];
        minDistanceStick = (int) distanceStick;
      }
    }
    
    return near;
  }
  
  void takeStick(Stick s){
    haveStick = true;
    s.taken = true;
  }
  
  void releaseStick(Stick s){
    haveStick = false;
    s.taken = false;
  }
}

void setup(){//Inicializador de objetos, variables y clases
  size(1000,1000);
  
  for (int i = 0; i < ant.length; ++i){
    Ant antInstance = new Ant(moveX, moveY);
    ant[i] = antInstance;
    rect(ant[i].position.x, ant[i].position.y, 10,10);
  }
  
  for (int i = 0; i < stick.length; i++){
    Stick stickInstance = new Stick(moveX_stick, moveY_stick);
    stick[i] = stickInstance;
    rect(stick[i].position.x, stick[i].position.y, 15, 2);
  }
}

void draw(){//Siempre esta en iteraciones
  for(int i = 0; i < ant.length; ++i){
    ant[i].move();
    ant[i].displayAnt();
    
    Stick stickFound = ant[i].distanceTakeStick();
    
    if(stickFound.taken == false && stickFound.position.x >= 0){
      if(ant[i].haveStick == true){
        ant[i].releaseStick(stickFound);
      }
      
      ant[i].takeStick(stickFound);
    }
  }
  
  for(Stick s : stick){
    s.displayStick();
  }
}
