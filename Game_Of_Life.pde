int grid[][];
int cols;
int rows;
int resolution = 5; // Set cell size. Lower resolution = more cells

void setup(){
  // Create canvas
  size(800, 600);
  
  // Calculate amount of rows and columns based on resolution
  cols = width / resolution;
  rows = height / resolution;
  
  // Create the grid
  grid = new int[cols][rows];
  
  // Fill the grid with random cells for the first generation
  for (int i = 0; i < cols; i++){
    for (int j = 0; j < rows; j++){
      grid[i][j] = floor(random(2));
    } 
  }
}

void draw(){
  // Create an empty grid for the next generation
  int[][] next = new int[cols][rows];
  
  // Position each cell based on resolution
  for (int i = 0; i < cols; i++){
    for (int j = 0; j < rows; j++){
      int x = i * resolution;
      int y = j * resolution;
      
      // If the value of the cell is 1, make it white 
      if (grid[i][j] == 1){
        fill(255);
      
      // If the value of the cell is 0, make it black
      } else {
        fill(0);
      }
      
      // Draw each cell as a rectangle with equal width and height 
      rect(x, y, resolution, resolution);
    }
  }
  
  // Check how many neighbors each cell has
  for (int i = 0; i < cols; i++){
    for (int j = 0; j < rows; j++){
      int neighbors = countNeighbors(grid, i, j);
      int state = grid[i][j];
      
      // Implement rules and change cell state accordingly
      if (state == 0 && neighbors == 3){
        next[i][j] = 1;
      } else if (state == 1 && (neighbors < 2 || neighbors > 3)){
        next[i][j] = 0;
      } else {
        next[i][j] = state;
      }
    }
  }
  
  // Update the grid so the next generation is displayed
  grid = next;
}

// Calculate how many neighbors each cell has
public int countNeighbors(int[][] grid, int x, int y){
  int sum = 0;
  for (int i = -1; i < 2; i++){
    for (int j = -1; j < 2; j++){
      int col = ((x + i + cols) % cols);
      int row = ((y + j + rows) % rows);
      
      // Add the state of each cell to the sum
      sum += grid[col][row];
    } 
  }
  
  // Subtract the cell that is being checked
  sum -= grid[x][y];
  return sum;
}
