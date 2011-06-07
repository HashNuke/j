j - task manager (v0.5.1)
==========================

j, stands for jot and is a simple command-line task manager written in Ruby. Inspired by [t-](http://www.penzba.co.uk/t-/t-.html) which was written in Python.


Install
--------

       gem install j

Note
-----

As of v0.6, the executable is not "jot" and not just "j". This is to avoid collisions with other software or scripts. So now feel free to alias the jot command to anything else you want :)

Usage
-------

* List todo tasks
       jot
* List all tasks
       jot -a
* List finished tasks
       jot -f
* Mark a task as done
       jot -m <key>
  F.ex: `j -m 3`
* Delete a task
       jot -d <key>
* Clear task list by deleting the *.todo* file (will be recreated later when needed)
       jot -c
* Display the scroll to use the magic
       jot -h

Key is a number that you will find next to a task, when you list tasks. It isn't the same everytime. So watch out!

All tasks are stored in the *.todo* file in your *$HOME* directory. However, if your current directory contains a *.todo* file, then that file will be used.


