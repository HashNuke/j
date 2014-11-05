require 'etc'

class J
  def initialize
    @tFilePath = "#{Dir.pwd}/.todo"
    if File.exists? @tFilePath
      @globalTodo = (Dir.pwd == ENV['HOME'] ? true : false)
    else
      @globalTodo = true
      @tFilePath = "#{ENV['HOME']}/.todo"
    end
  end

  def addTask(task)
    taskRecord = createTask task
    puts "*NEW* " + "TODO".foreground(:red).bright + " " + task
    writeTaskToFile taskRecord
  end

  def listTasks(listType=:todo)
    readTasks
    if not @tasks.empty?
      @tasks.each_with_index do |task, i|
        puts formatTask(task, i) if ((task[:status] == "DONE" and (listType == :done or listType==:all)) or \
                                     (task[:status] == "TODO" and (listType == :todo or listType==:all)))
      end
    else
      puts(@globalTodo ? "No tasks!" : "No tasks in project todo list. To delete project todo list use option -c")
    end
  end

  def markTask(key)
    readTasks
    key = key.to_i
    if @tasks and @tasks[key]
      @tasks[key].store(:status, "DONE")
      puts "DONE".color(:green).bright + " " + @tasks[key][:title]
      dumpTasksToFile
    else
      puts "No such task found!"
    end
  end

  def deleteTask(key)
    readTasks
    key = key.to_i
    if @tasks and @tasks[key]
      task = @tasks[key]
      @tasks.delete_at(key)
      puts "Deleted " + task[:status].color((task[:status] == "TODO" ? :red : :green)).bright + " " + task[:title]
      dumpTasksToFile
    else
      puts "No such task found!"
    end
  end
  
  def clearList
    File.delete(@tFilePath) if File.exists?(@tFilePath)
    puts(@globalTodo ? "Cleared todo list" : "Cleared project todo list")
  end

  def validKey(key)
    return true unless key.match(/\A[0-9]+\Z/).nil?
  end 
  
  private

  def dumpTasksToFile
    f = tFile("w+")
    @tasks.each do |task|
      taskRecord = task[:status] + " " + task[:title] + "\n"
      f << taskRecord
    end
    f.close
  end
  
  def formatTask(task,key)
    return ("[" + key.to_s.foreground(:black).background(:white).bright + "]".background(:white)).background(:white) + \
      " " + task[:status].foreground((task[:status] =="TODO" ? :red : :green)).bright + " " + task[:title]
  end
  
  def tFile(mode="r+")
    if File.exists?(@tFilePath)
      File.open(@tFilePath, mode)
    else
      File.new(@tFilePath, "w+")
    end
  end
  
  def createTask(task)
    return "TODO #{task}"
  end

  def writeTaskToFile(taskRecord)
    f = tFile "a+"
    f << taskRecord << "\n"
  end

  def readTasks
    @tasks = []

    # Record Pattern: <status:TODO/DONE> <space> <task>
    taskRecordPattern = /(?<status>(TODO|DONE))\s(?<title>.+)\Z/

    tFile.readlines.each do |l|
      next if l.size < 2
      match = taskRecordPattern.match l
      task = {
        status: match[:status],
        title: match[:title]
      }
      @tasks << task
    end
  end
end
