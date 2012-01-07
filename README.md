j - task manager (v0.5.1)
==========================

j, stands for jot and is a simple command-line task manager written in Ruby. Inspired by [t-](http://www.penzba.co.uk/t-/t-.html) which was written in Python.


Install
--------

       gem install j

Note
-----

As of version 0.6.11, the executable is available as both "j" and "jot". So feel free to use whichever you feel is world changing ;)

Usage
-------

* List todo tasks

       j

* List all tasks

       j -a

* List finished tasks

       j -f

* Mark a task as done

       j -m <key>

F.ex: `j -m 3`

* Delete a task

       j -d <key>

* Clear task list by deleting the *.todo* file (will be recreated later when needed)

       j -c

* Display the scroll to use the magic

       j -h

Key is a number that you will find next to a task, when you list tasks. It isn't the same everytime. So watch out!

**All tasks are stored in the *.todo* file in your *$HOME* directory. However, if your current directory contains a *.todo* file, then that file will be used.**
