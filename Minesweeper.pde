import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons;
private ArrayList <MSButton> mines;
private boolean first, lost;
private int numMines;

void setup ()
{
    numMines = (int)(Math.random()*10)+90;
    first = true;
    lost = false;
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    mines = new ArrayList<MSButton>();
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r<NUM_ROWS; r++)
    {
      for(int c = 0; c<NUM_COLS; c++)
      {
        Interactive.make( this );
        buttons[r][c] = new MSButton(r,c);
      }
    }
    setMines(numMines);
}
public void setMines(int n)
{
    for(int i = 0; i<n; i++)
    {
      int r = (int)(Math.random()*20);
      int c = (int)(Math.random()*20);
      System.out.println(r + ", " + c);
      if(mines.contains(buttons[r][c])||buttons[r][c].clicked)
        i--;
      else
        mines.add(buttons[r][c]);
    }
}

public void draw ()
{
    background( 0 );
    if(numClicked()==400-numMines)
      win();
}
public int numClicked()
{
    int sum = 0;
    for(int i = 0; i<20; i++)
      for(int s = 0; s<20; s++)
        if(buttons[i][s].clicked)
          sum++;
    return sum;
}
public void win()
{
    noLoop();
    textSize(70);
    fill(255);
    text("You Diedn't", 200,200);
    textSize(11.5);
}
public void lose()
{
    noLoop();
    textSize(90);
    fill(255);
    text("You Died", 200,200);
    textSize(11.5);
}
public boolean isValid(int r, int c)
{
    if(r>=0&&c>=0&&r<NUM_ROWS&&c<NUM_COLS)
      return true;
    return false;
}
