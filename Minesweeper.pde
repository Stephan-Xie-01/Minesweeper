

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 20;



public void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );

    buttons = new MSButton[NUM_ROWS][NUM_COLS];

    for(int y = 0; y < NUM_ROWS; y++)
    {
        for(int x = 0; x < NUM_COLS; x++)
        {
            buttons[y][x]= new MSButton(y,x);
        }
    }
    //your code to declare and initialize buttons goes here  
    setBombs();
}
public void setBombs()
{
    for(int i = 0; i < 40; i++)
    {
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);

        if(!bombs.contains(buttons[row][col]))
            bombs.add(buttons[row][col]);
        
    }  //your code
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    int markedBombs = 0;
    int clickedButtons = 0;


    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(buttons[r][c].isClicked() == true && !bombs.contains(this))
                clickedButtons++;
            else if(bombs.contains(this) && buttons[r][c].isMarked() == true)
                markedBombs++;
        }
    }
    if(NUM_ROWS*NUM_COLS == markedBombs + clickedButtons)
        return true;
    //your code here
    return false;
}
public void displayLosingMessage()
{
    String loseMessage = "You Lose";
    for(int i = 0; i < loseMessage.length(); i++)
        buttons[NUM_ROWS/2][i + 6].setLabel(""+ loseMessage.charAt(i));

}
public void displayWinningMessage()
{
    String winMessage = "You Win";
    for(int i = 0; i < winMessage.length(); i++)
        buttons[NUM_ROWS/2][i + 6].setLabel(""+ winMessage.charAt(i));


}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    public void setClicked(boolean c)
    {
        clicked = c;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(bombs.contains(this) && isMarked() == false)
        {
            if(keyPressed == true)
            {
                marked = true;
            }

            else
            {
                for(int i = 0; i < bombs.size(); i++)
                    bombs.get(i).setClicked(true);
                displayLosingMessage();

            }
        }
         

        else if (countBombs(r,c) > 0) {
            if(isMarked() == false)
                label = "" + countBombs(r,c); 
        }
        else {

            if(isValid(r,c-1) && buttons[r][c-1].isClicked() == false)
                buttons[r][c-1].mousePressed();
            if(isValid(r,c+1) && buttons[r][c+1].isClicked() == false)
                buttons[r][c+1].mousePressed();
            if(isValid(r -1,c) && buttons[r-1][c].isClicked() == false)
                buttons[r][c-1].mousePressed();
            if(isValid(r+1,c) && buttons[r+1][c].isClicked() == false)
                buttons[r+1][c].mousePressed();
            if(isValid(r-1,c-1) && buttons[r-1][c-1].isClicked() == false)
                buttons[r-1][c-1].mousePressed();
            if(isValid(r-1,c+1) && buttons[r-1][c+1].isClicked() == false)
                buttons[r-1][c+1].mousePressed();
            if(isValid(r +1,c-1) && buttons[r+1][c-1].isClicked() == false)
                buttons[r+1][c-1].mousePressed();
            if(isValid(r+1,c+1) && buttons[r+1][c+1].isClicked() == false)
                buttons[r+1][c+1].mousePressed();

        }

           
        //your code here
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);

        if(isWon() == true)
            displayWinningMessage();
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r > -1 && r < NUM_ROWS && c > -1 && c < NUM_COLS)
            return true;
        
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here

        if(isValid(row + 1, col) && bombs.contains(buttons[row + 1][col]))
            numBombs+=1;
        if(isValid(row - 1, col) && bombs.contains(buttons[row - 1][col]))
            numBombs+=1; 
        if(isValid(row, col + 1) && bombs.contains(buttons[row][col + 1]))
            numBombs+=1;
        if(isValid(row, col - 1) && bombs.contains(buttons[row][col - 1]))
            numBombs+=1;
        if(isValid(row + 1, col + 1) && bombs.contains(buttons[row + 1][col + 1]))
            numBombs+=1;
        if(isValid(row + 1, col - 1) && bombs.contains(buttons[row + 1][col - 1]))
            numBombs+=1;
        if(isValid(row - 1, col + 1) && bombs.contains(buttons[row - 1][col + 1]))
            numBombs+=1;
        if(isValid(row - 1, col - 1) && bombs.contains(buttons[row - 1][col - 1]))
            numBombs+=1;

        return numBombs;
        
    }
}



