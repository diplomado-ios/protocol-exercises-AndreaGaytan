# Protocol Exercises

## First Challenge
The `printTable(_:)` function has a bug: It crashes if any of the data items are longer than the label of their column. 
Try changing the age of a person to _1,000_ to see this happen. Fix the bug. 

> [!NOTE]  
> Your solution will likely result in incorrect table formatting; that is fine for now. You will fix the formatting in the gold challenge, below.


## Second Challenge
Create a new type, `BookCollection`, that conforms to `TabularDataSource`. 
Calling printTable(_:) on a book collection should show a table of books with columns for _titles_, _authors_, and _average reviews_.
 
> [!Note]
> Unless all the books you use have very short titles and author names, you will need to have completed the previous challenge!


## Third Challenge (optional)
After you fixed the crashing bug in the first challenge, the table rows and columns were likely misaligned. 
Fix your solution to correctly align the table rows and columns. Verify that your solution does not crash with values longer than their column labels.
