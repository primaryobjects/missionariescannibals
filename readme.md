Missionaries and Cannibals
=========
### in R

This program solves the Missionaries and Cannibals AI problem. See http://www.aiai.ed.ac.uk/~gwickler/missionaries.html

Rules
---

On one bank of a river are three missionaries and three cannibals. There is one boat available that can hold up to two people and that they would like to use to cross the river. If the cannibals ever outnumber the missionaries on either of the river’s banks, the missionaries will get eaten. How can the boat be used to safely carry all the missionaries and cannibals across the river?

Running It
---

```
findSolution(startState)
```

Output
---

The program finds all possible solutions from a starting state, within a depth of 15. It uses recursion to evaluate a depth-first search across the transition paths. Output is in the following format:

m1c1

Where 'm' indicates the number of missionaries being moved and 'c' indicates the number of cannibals being moved. At each move, the boat alternates between right and left.

Example output:

```
[1] "*********************** Solution found in 11 steps!"
[1] "m1c1"
[1] "m1c0"
[1] "m0c2"
[1] "m0c1"
[1] "m2c0"
[1] "m1c1"
[1] "m2c0"
[1] "m0c1"
[1] "m0c2"
[1] "m0c1"
[1] "m0c2"
```

In the above example, the first step is to move 1 mercenary and 1 cannibal to the right bank. The second step moves 1 mercenary back to the left bank. The third step moves 2 cannibals to the right bank (all 3 cannibals are now on the right bank). The fourth step moves 1 cannibal back to the left bank. The fifth step moves 2 missionaries to the right bank (there are now equal missionaries and cannibals on both banks, m1c1 and m2c2). For remaining steps, see graph at http://www.aiai.ed.ac.uk/~gwickler/missionaries.html.

License
----

MIT

Author
----
Kory Becker
http://www.primaryobjects.com/kory-becker
