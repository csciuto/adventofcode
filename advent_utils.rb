module AdventUtils
  
  def self.get_data(file_name)
    if ARGV[0].nil?
  	  data = open(file_name).read
    else
      data = open(ARGV[0]).read
    end
  end
  
end