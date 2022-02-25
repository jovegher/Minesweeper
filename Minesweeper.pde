import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLUMNS = 20;
public final static int MINES = 30;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>();

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLUMNS];
  for (int r = 0; r < NUM_ROWS; r++)
    for (int c = 0; c < NUM_COLUMNS; c++)
      buttons[r][c] = new MSButton(r, c);

  for (int i = 0; i < MINES; i++)
    setMines();
}
public void setMines()
{
  int randRow = (int)(Math.random()*NUM_ROWS);
  int randCol = (int)(Math.random()*NUM_COLUMNS);
  if (!mines.contains(buttons[randRow][randCol]))
    mines.add(buttons[randRow][randCol]);
}
public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
  else  
    displayLosingMessage();
}
public boolean isWon()
{
  //your code here
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLUMNS; c++) {
      if (!mines.contains(buttons[r][c] && !buttons[r][c].isClicked())) {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
  //your code here
  for (int i = 0; i < mines.size; i++) {
    mines.get(i).mousePressed();
    fill(255);
    for (int r = 0; r < NUM_ROWS; r++)
      for (int c = 0; c < NUM_COLUMNS; c++) {
        buttons[r][c].setLabel("");
      }
    buttons[10][8].setLabel("E");
    buttons[10][9].setLabel("Z");
    buttons[10][11].setLabel("L");
  }
}
public void displayWinningMessage()
{
  //your code here
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLUMNS; c++) {
      buttons[r][c].setLabel();
      buttons[10][9].setLabel("G");
      buttons[10][10].setLabel("G");
    }
  }
}
public boolean isValid(int r, int c)
{
  if ((r >= 0 && r < NUM_ROWS) && (c >=0 && c < NUM_COLUMNS))
    return true; 
  return false;
}
public int countMines(int row, int col)
{ 
  int numMines = 0;
  if (isValid(row-1, col-1)) {
    if (mines.contains(buttons[row-1][col-1]))
      numMines++;
  }
  if (isValid(row-1, col)) {
    if (mines.contains(buttons[row-1][col]))
      numMines++;
  }
  if (isValid(row-1, col+1)) {
    if (mines.contains(buttons[row-1][col+1]))
      numMines++;
  }
  if (isValid(row, col-1)) {
    if (mines.contains(buttons[row][col-1]))
      numMines++;
  }
  if (isValid(row, col+1)) {
    if (mines.contains(buttons[row][col+1]))
      numMines++;
  }
  if (isValid(row+1, col-1)) {
    if (mines.contains(buttons[row+1][col-1]))
      numMines++;
  }
  if (isValid(row+1, col)) {
    if (mines.contains(buttons[row+1][col+1]))
      numMines++;
  }
  if (isValid(row+1, col+1)) {
    if (mines.contains(buttons[row+1][col+1]))
      numMines++;
  }
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLUMNS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    //your code here
    if (mouseButton == RIGHT) {
      flagged = !flagged;
    }
    if (flagged == false) {
      clicked = false;
    } else if (mines.contains(this)) {
      for (int r = 0; r < NUM_ROWS; r++) {
        for (int c = 0; c < NUM_COLUMNS; c++) {
          if (buttons[r][c] == false) {
            buttons[r][c].mousePressed();
          }
        }
      }
    } else if (countMines(myRow, myCol) > 0) {
      setLabel(countMines(myRow, myCol));
    }
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
