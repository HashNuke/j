HowItWorks
---------------

Checks for a .t.list file in $HOME
if not present create it

* list (todo) tasks (t)
  get the contents of the file by line and push to an array
  and print each in the format: <key> | <status> | <task>
  with option -a list all tasks

* create task (t <string>)
  just append the new task to the file in this format
  <key> | <status> | <task>

* Mark as done (t -d <key>)
  find dump tasks to array, delete that particular task and write back
  show message. Else show error

* clear list (t -c)
  delete the .t.list file
