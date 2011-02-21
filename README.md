j - task manager (v0.4.2)
=================

j, stands for jot and is a simple command-line task manager written in Ruby. Inspired by [t-](http://www.penzba.co.uk/t-/t-.html) which was written in Python.

Install:
--------

       gem install j

Usage:
-------

* List todo tasks
       j
* List all tasks
       j -a
* List done tasks
       j -d
* Mark a task as done
       j -m <key>
  F.ex: *j -m 3*
* Remove a task
       j -r <key>
* Clear task list
       j -c

Key is a number that you will find next to a task, when you list tasks. It isn't the same everytime. So watch out.

All tasks are stored in the *.todo* file in your $HOME directory.

This gem is a work-in-progress and will be updated regularly in the next few days until it gains the shape of the idea in the author's head.
