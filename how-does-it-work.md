HowItWorks
---------------

Checks for a .t.list file in $HOME
if not present create it

* list (todo) tasks:
  get the contents of the file by line and push to an array
  and print each in the format: <hash> | <status> | <task>
  with option -a list all tasks

* create task (t <string>)
  just append the new task to the file in this format
  <hashOfTimeStamp> | <status> | <task>

* Mark as done (-d <last3CharsOfHash>)
  find dump tasks to array, delete that particular task and write back
  show message. Else show error

* clear list
  --clear
  just delete the contents of the .t.list file
