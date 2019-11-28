class Elementary{
  int w = 8;
  int[] cells;
  int[] ruleset;
  int count = 0;
  
  Elementary(){
    cells = new int[w];
    ruleset = new int[w];
    completeRules();
  }
  
  void completeRules(){
    for(int i = 0; i < cells.length; ++i){
      cells[i] = int(random(2));
      ruleset[i] = int(random(2));
    }
  }
  
  void rules(){
    int[] next = new int[cells.length];
    
    for(int i = 1; i < cells.length-1; ++i){
      int left = cells[i-1];
      int actual = cells[i];
      int right = cells[i+1];
      
      if (left == 1 && actual == 1 && right == 1){
        next[i] = ruleset[0];
      } else if (left == 1 && actual == 1 && right == 0){
        next[i] = ruleset[1];
      } else if (left == 1 && actual == 0 && right == 1){
        next[i] = ruleset[2];
      } else if (left == 1 && actual == 0 && right == 0){
        next[i] = ruleset[3];
      } else if (left == 0 && actual == 1 && right == 1){
        next[i] = ruleset[4];
      } else if (left == 0 && actual == 1 && right == 0){
        next[i] = ruleset[5];
      } else if (left == 0 && actual == 0 && right == 1){
        next[i] = ruleset[6];
      } else {
        next[i] = ruleset[7];
      }
    
      cells = next;
      ++count;
    }  
  }
  
  void display(){
    for (int i = 0; i < cells.length; ++i){
      if(cells[i] == 1){
        fill(255);
      } else {
        fill(20);
        stroke(0);
        rect(i*w, count*w, w, w);
      }
    }
    if(count < height/w){
      rules();
    }
  }
}

Elementary elementary;

void setup(){
  size(600,600);
  frameRate(24);
  elementary = new Elementary();
}

void draw(){
  background(255);
  elementary.display();
}
