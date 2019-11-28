class gameOfLife{
  int w = 8;
  int columns, rows;
  int[][] environment;
  
  gameOfLife(){
    columns = width/w;
    rows = height/w;
    environment = new int[columns][rows];
    
    completeRules();
  }
  
  void completeRules(){ //Completando en ceros y unos en el entorno
    for(int i = 1; i < columns - 1; ++i){
      for(int j = 1; j < rows - 1; ++j){
        environment[i][j] = int(random(2));
      }
    }
  }
  
  void create(){
    
    int[][] copy = new int[columns][rows];
    
    for(int x = 1; x < columns - 1; ++x){
      for(int y = 1; y < rows - 1; ++y){
        
        int neighbors = 0;    
        for(int i = -1; i <= 1; ++i){
          for(int j = -1; j <= 1; ++j){
            neighbors += environment[x+i][y+j];
          }
        }
        
        neighbors -= environment[x][y];
        
        if((environment[x][y] == 1) && (neighbors <  2)) {
          copy[x][y] = 0;
        } else if ((environment[x][y] == 1) && (neighbors > 3)){
          copy[x][y] = 0;
        } else if ((environment[x][y] == 0) && (neighbors == 3)){
          copy[x][y] = 1;
        } else {
          copy[x][y] = environment[x][y]; 
        }
      }
    }
    environment = copy;
  }
  
  void display(){
    for(int i = 0; i < columns; ++i){
      for(int j = 0; j < rows; ++j){
        if((environment[i][j] == 1)){
          fill(0);
        } else {
          fill(255);
        }
        stroke(0);
        rect(i*w, j*w, w, w);
      }
    }
  }
}

gameOfLife gol;

void setup(){  
  size(400,400);
  frameRate(24);
  gol = new gameOfLife();
}

void draw(){
  background(255);
  gol.create();
  gol.display();
  gol.completeRules();
}
