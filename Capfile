# Load .env file
require 'dotenv/load'

# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Load the Git SCM plugin
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Load tasks from gems
require 'capistrano/composer'

# Load tasks from Capistrano WPCLI
require 'capistrano/wpcli'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
# Customize this path to change the location of your custom tasks.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
