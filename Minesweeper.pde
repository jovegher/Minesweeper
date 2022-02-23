import de.bezier.guido.*;
public final static int NUM_ROWS = 5;
public final static int NUM_COLUMNS = 5;
public final static int MINES = 80;
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


  setMines();
}
public void setMines()
{

}
  public void draw ()
  {
    background( 0 );
    if (isWon() == true)
      displayWinningMessage();
  }
  public boolean isWon()
  {
    //your code here
    return false;
  }
  public void displayLosingMessage()
  {
    //your code here
  }
  public void displayWinningMessage()
  {
    //your code here
  }
  public boolean isValid(int r, int c)
  {
    //your code here
    return false;
  }
  public int countMines(int row, int col)
  {
    int numMines = 0;

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
    }
    public void draw () 
    {    
      if (flagged)
        fill(0);
      else if( clicked && mines.contains(this) ) 
           fill(255,0,0);
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
  }
