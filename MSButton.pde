public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
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
      if(first)
      {
        first = false;
        for(int i = -2; i<2; i++)
        {
          for(int s = -2; s<2; s++)
          {
            if(mines.contains(buttons[myRow+i][myCol+s]))
            {
              setMines(1);
              mines.remove(buttons[myRow+i][myCol+s]);
            }
          }
        }
      }
      if (mouseButton == LEFT&&!flagged&&!clicked) {
        clicked = true;
        if(mines.contains(this))
          lost = true;
        else if(countMines(myRow,myCol)>0)
          setLabel(countMines(myRow,myCol));
        else if(countMines(myRow,myCol)==0)
          for(int p = -1; p<2; p++)
            for(int k = -1; k<2; k++)
              if(isValid(myRow+p,myCol+k))
                if(!buttons[myRow+p][myCol+k].clicked) 
                  buttons[myRow+p][myCol+k].mousePressed();
      }
      else if (mouseButton == LEFT)
      {
        if (clicked&&!flagged)
          if(getLabel() == countFlags())
            for(int i = -1; i<2; i++)
              for(int s = -1; s<2; s++)
                if(isValid(myRow+i,myCol+s))
                  if(!buttons[myRow+i][myCol+s].clicked) 
                    if(!mines.contains(buttons[myRow+i][myCol+s]))
                      chord(myRow, myCol);
      }
      else if (mouseButton == RIGHT)
      {
        if(!flagged && !clicked)
          this.flagged = true;
        else if(flagged && !clicked)
          this.flagged = false;
      }
    }
    public void draw () 
    {   
        if (flagged)
            fill(0,255,0);
        else if(clicked&&mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
        if(lost)
          lose();
        else if(numClicked()==400-numMines)
          win();
    }
    public int countMines(int r, int c)
    {
      int sum = 0;
      for(int i = -1; i<2; i++)
        for(int s = -1; s<2; s++)
          if(isValid(r+i,c+s))
            if(mines.contains(buttons[r+i][c+s]))
              sum++;
      return sum;
    }
    public int countFlags()
    {
      int sum = 0;
      for(int i = -1; i<2; i++)
        for(int s = -1; s<2; s++)
          if(isValid(myRow+i,myCol+s))
            if(buttons[myRow+i][myCol+s].flagged)
              sum++;
      return sum;
    }
    public void chord(int r, int c)
    {
      clicked = true;
      for(int i = -1; i<2; i++)
      {
        for(int s = -1; s<2; s++)
        {
          if(isValid(myRow+i,c+s))
          {
            if(!buttons[r+i][c+s].clicked&&!buttons[r+i][c+s].flagged) 
            {
              buttons[r+i][c+s].clicked = true;
              if(mines.contains(buttons[r+i][c+s]))
                lost = true;
              else if(!mines.contains(buttons[r+i][c+s])&&countMines(r+i,c+s)>0)
                buttons[r+i][c+s].setLabel(countMines(r+i,c+s));
              else if(countMines(r+i,c+s)==0)
                for(int a = -1; a<2; a++)
                  for(int b = -1; b<2; b++)
                    if(isValid(r+i+a,c+s+b))
                      if(!buttons[r+i+a][c+s+b].clicked) 
                        buttons[r+i+a][c+s+b].mousePressed();
              else if(mines.contains(buttons[r+i][c+s]))
                lost = true;
            }
          }
        }
      }
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public int getLabel()
    {
        return Integer.parseInt(myLabel);
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
