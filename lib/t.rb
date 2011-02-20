require 'etc'

class T
  def initialize
    userHome = Etc.getpwuid.dir
    @tFilePath = userHome << '/' << ".t.list"
    
  end

  def createTask(task)
    taskRecord = makeTask task
    writeTaskToFiletaskRecord
  end

  def listTasks
    readTasks
    if @tasks.count > 0
      @tasks.each do |task|
        record = task[:hash] << " " << task[:status] << task[:title]
        puts record
      end
    else
      puts "No tasks"
    end
  end

  def clear_list
    tFile.exists?
  end
  
  private

  def tFile(mode="w+")
    if File.exist?(@tFilePath)
      File.new(tFilePath, "w")
    else
      File.open(@tFilePath, mode)
    end
  end
  
  def makeTask(task)
    key = rand(32**4).to_s
    taskRecord = key << " " << "TODO" << " " << task
    return taskRecord
  end

  def writeTaskToFile(taskRecord)
    f = tFile "a+"
    f << taskRecord << "\n"
  end

  def readTasks
    @tasks = tFile "r+"
    # REcord Pattern: <Hash> <Space> <Status:TODO/DONE> <space> <task>
    taskRecordPattern = /(?<key>\w+)\s(?<status>\w+)\s(?<title>\w+)/
    tFile.readlines.each do |l|
      next if l.length<2
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
