require 'etc'

class T
  def initialize
    userHome = Etc.getpwduid.dir
    @tFilePath = userHome << '/' << ".t.list"
    if File.exist?(tFilePath)
      File.new(tFilePath, "w")
    end
  end

  def tFile(mode="w+")
    File.open(@tFilePath, mode)
  end
  
  
  def createTask(task)
    taskRecord = makeTask task
    writeTaskToFiletaskRecord
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

  def listTasks
    readTasks
    @tasks.each do |task|
      record = task[:hash] << " " << task[:status] << task[:title]
      puts record
    end
  end

end
