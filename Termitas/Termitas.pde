PTermita[] termitaArreglo= new PTermita[20];
PPalito[] palitoArreglo= new PPalito[50];
int width = 600;
int height = 600;

void setup(){
  //width & height
  size(600,600);
  for (int i = 0; i < termitaArreglo.length; i++){
     int termitaX = (int) random(250, 350);
     int termitaY = (int) random(250, 350);
     PTermita termita = new PTermita(termitaX, termitaY);
     termitaArreglo[i] = termita;
     rect(termitaArreglo[i].posicion.x, termitaArreglo[i].posicion.y, 10, 10);
  }
  
  for (int i = 0; i < palitoArreglo.length; i++){
     int palitoX = (int) random(0, 600);
     int palitoY = (int) random(0, 600);
     PPalito palito = new PPalito(palitoX, palitoY);
     palitoArreglo[i] = palito;
     rect(palitoArreglo[i].posicion.x, palitoArreglo[i].posicion.y, 15, 2);
  }
}

void draw(){
   background(255);
  for (int i = 0; i < termitaArreglo.length; i++){
      termitaArreglo[i].move();
      termitaArreglo[i].display();
      //Verificar si hay palos alrededor
      PPalito paloEncontrado = termitaArreglo[i].look();
      //Si encontro un palo y el palo NO esta taken
      if(paloEncontrado.taken == false && paloEncontrado.posicion.x >= 0){
        //Soltar el palo anterior antes de agarrar uno nuevo
        if(termitaArreglo[i].tienePalito == true){
          termitaArreglo[i].soltarPalito(paloEncontrado);
        }
        //tomar el palito
        termitaArreglo[i].agarrarPalito(paloEncontrado);
      }
      //Revisar si se salio de la pantalla
      termitaArreglo[i].wrapAround();
      //Mover el palito
      if(termitaArreglo[i].tienePalito == true && paloEncontrado.posicion.x >= 0){
        paloEncontrado.posicion.x =  termitaArreglo[i].posicion.x;
        paloEncontrado.posicion.y =  termitaArreglo[i].posicion.y;
      }
  }
  //Dibujar palitos
  for(PPalito p : palitoArreglo){
  p.display();
  }
  
}

class PTermita {
  PVector posicion;
  boolean tienePalito;
  
  public PTermita(int x, int y) { //constructor
    posicion = new PVector(x,y,0);
    tienePalito = false;
  }

 void move() {
   int randomDoubleX = (int) random(-5, 5);
   int randomDoubleY = (int) random(-5, 5);
   posicion.x += randomDoubleX;
   posicion.y += randomDoubleY;
 }
 
 void display(){
   fill(0);
   rect(posicion.x, posicion.y, 10, 10);
 }
 
 void wrapAround(){
   //regresar al inicio
   if(posicion.x > width){
     posicion.x = 0;
   }else if(posicion.x < 0){
     posicion.x = width;
   }else if(posicion.y > height){
     posicion.y = 0;
   }else if(posicion.y < 0){
     posicion.y = height;
   }
   this.display();
 }
   
  PPalito look(){
       double minDist = 10;
       PPalito prospecto = new PPalito(-10,-10);
       for (int i = 0; i < palitoArreglo.length; i++){
         double ac = Math.abs(posicion.y - palitoArreglo[i].posicion.y);
         double cb = Math.abs(posicion.x - palitoArreglo[i].posicion.x);
         double distancia = Math.hypot(ac, cb);
         
         if(distancia < minDist){
         prospecto = palitoArreglo[i];
         minDist = distancia;
         }
       }
       return prospecto;
  }
  
  void agarrarPalito(PPalito p){
    tienePalito = true;
    p.taken = true;
  }
  
  void soltarPalito(PPalito p){
    tienePalito = false;
    p.taken = false;
  }
}

class PPalito {
  PVector posicion;
  boolean taken;
  
  public PPalito(int x, int y) { //constructor
    posicion = new PVector(x,y,0);
    taken = false;
  }

  void display(){
  fill(230, 40, 2);
  rect(posicion.x, posicion.y,13,3);
  }

}
