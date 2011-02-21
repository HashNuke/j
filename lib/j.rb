require 'etc'

class J
  def initialize
    userHome = Etc.getpwuid.dir
    @tFilePath = userHome << '/' << ".todo"
    
  end

  def addTask(task)
    taskRecord = createTask task
    writeTaskToFile taskRecord
  end

  def listTasks(listType=:todo)
    readTasks
    if @tasks.count > 0
      @tasks.each_with_index do |task, i|
        if ((task[:status] == "DONE" and (listType == :done or listType==:all)) or (task[:status] == "TODO" and (listType == :todo or listType==:all)))
          puts formatTask(task, i)
        end
      end
    else
      puts "No tasks"
    end
  end

  def markTask(key)
    readTasks
    key = key.to_i
    if (key <= @tasks.length)
      @tasks[key].store(:status, "DONE")
      puts "DONE".color(:green).bright << " " << @tasks[key][:title]
      dumpTasksToFile
    else
      puts "No such task found!"
    end
  end

  def deleteTask(key)
    readTasks
    key = key.to_i
    if key <= @tasks.count
      task = @tasks[key]
      @tasks.delete_at(key)
      if task[:status] == "TODO"
        puts "Deleted " << task[:status].color(:red).bright << " " << task[:title]
      else
        puts "Deleted " << task[:status].color(:green).bright << " " << task[:title]
      end
      dumpTasksToFile
    else
      puts "No such task found!"
    end
  end
  
  def clearList
    if File.exists?(@tFilePath)
      File.delete(@tFilePath)
    end
    puts "Cleared list"
  end
  
  private

  def dumpTasksToFile
    f = tFile("w+")
    @tasks.each do |task|
      taskRecord = task[:status] << " " << task[:title]
      f << taskRecord
    end
    f.close
  end
  
  def formatTask(task,key)
    key = ("[" << key.to_s.foreground(:black).background(:white).bright << "]".background(:white))
    key = key.background(:white)
    if task[:status] =="TODO"
      key << " " << task[:status].foreground(:red).bright << " " << task[:title]
    else
      key << " " << task[:status].foreground(:green).bright << " " << task[:title]
    end
  end
  
  def tFile(mode="r+")
    if File.exists?(@tFilePath)
      File.open(@tFilePath, mode)
    else
      File.new(@tFilePath, "w+")
    end
  end
  
  def createTask(task)
    "TODO" << " " << task
  end

  def writeTaskToFile(taskRecord)
    f = tFile "a+"
    f << taskRecord << "\n"
  end

  def readTasks
    @tasks = []
    # REcord Pattern: <status:TODO/DONE> <space> <task>
    taskRecordPattern = /(?<status>\w+)\s(?<title>[\w\s]+)/
    tFile.readlines.each do |l|
      if (l.length < 2)
        next
      end
      match = taskRecordPattern.match l
      task = {
        :status=> match[:status],
        :title=> match[:title]
      }
      @tasks.push task
    end
  end
end
