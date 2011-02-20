require 'etc'

class T
  def initialize
    userHome = Etc.getpwuid.dir
    @tFilePath = userHome << '/' << ".t.list"
    
  end

  def addTask(task)
    taskRecord = createTask task
    writeTaskToFile taskRecord
  end

  def listTasks(listType=:todo)
    readTasks
    if @tasks.count > 0
      @tasks.each do |task|
        if ((task[:status] == "DONE" and (listType == :done or listType==:all)) or (task[:status] == "TODO" and (listType == :todo or listType==:all)))
          puts formatTask(task)
        end
      end
    else
      puts "No tasks"
    end
  end

  def markTask(key)
    if key.length < 3
      puts "key must be atleast 3 characters"      
    else
      readTasks
      regex = /#{Regexp.quote(key)}\z/
      @tasks.each_with_index do |task, i|
        unless regex.match(task[:key]).nil?
          @tasks[i].store(:status, "DONE")
          puts "DONE".color(:green).bright << " " << task[:title]
        end
      end
      dumpTasksToFile
    end
  end

  def deleteTask(key)
    if key.length < 3
      puts "key must be atleast 3 characters"      
    else
      deleteElement = -1
      readTasks
      regex = /#{Regexp.quote(key)}\z/
      @tasks.each_with_index do |task, i|
        unless regex.match(task[:key]).nil?
          deleteElement = i
          break
        end
      end
      
      if (deleteElement > -1)
        task = @tasks[deleteElement]
        @tasks.delete_at(deleteElement)
        puts "Deleted " << task[:status].color(:red).bright << " " << task[:title]
        dumpTasksToFile
      end
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
      taskRecord = task[:key] << " " << task[:status] << " " << task[:title]
      f << taskRecord
    end
    f.close
  end
  
  def formatTask(task)
    shortKey = "(" << task[:key].reverse[0..2].reverse << ") "
    if task[:status] =="TODO"
      shortKey << task[:status].foreground(:red).bright << " " << task[:title]
    else
      shortKey << task[:status].foreground(:green).bright << " " << task[:title]
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
    key = rand(32**4).to_s
    taskRecord = key << " " << "TODO" << " " << task
    return taskRecord
  end

  def writeTaskToFile(taskRecord)
    f = tFile "a+"
    f << taskRecord << "\n"
  end

  def readTasks
    @tasks = []
    # REcord Pattern: <Hash> <Space> <Status:TODO/DONE> <space> <task>
    taskRecordPattern = /(?<key>\w+)\s(?<status>\w+)\s(?<title>[\w\s]+)/
    tFile.readlines.each do |l|
      if (l.length < 2)
        next
      end
      match = taskRecordPattern.match l
      task = {
        :key=> match[:key],
        :status=> match[:status],
        :title=> match[:title]
      }
      @tasks.push task
    end
  end
end
