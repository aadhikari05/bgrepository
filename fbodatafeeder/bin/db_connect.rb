require "rubygems"
require "mysql"
require "yaml"

module DBConnect  
  def dbconnection
    config = YAML::load_file(File.dirname(__FILE__) + "/../config/config.yml")
    Mysql.real_connect(config['database']['host'], config['database']['username'], config['database']['password'], config['database']['schema'])
  end
end
