module BaristaMatic

end

# whenever you would want to use production, change :development to and ENV["RUN_MODE"]
# and supply it as an environment variable
Bundler.require(:default, :development)

require 'yaml' # for YAML parsing in recipe and ingredients database
require 'bigdecimal' # ingredient costs cannot be float because of precision errors
require 'bigdecimal/util' # for .to_d utility methods

require 'drink'
require 'recipe_ingredient'
require 'ingredients_storage'
require 'storage_commands/restock'
require 'storage_commands/consume'
