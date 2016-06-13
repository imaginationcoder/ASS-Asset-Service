CarrierWave.configure do |config|

  if Rails.env.production? # get from secrets.yml
    aws_key = Rails.application.secrets.aws_access_key_id
    aws_secret = Rails.application.secrets.aws_secret_access_key
  else # read from local file
    dev_config = YAML.load_file('/home/maisapride/upender/RubyMineWorkSpace/dev-assets-secrets.yml')
    aws_key = dev_config['AWS']['key']
    aws_secret = dev_config['AWS']['secret']
  end

  config.fog_credentials = {
      provider:              'AWS',           # required
      aws_access_key_id:     aws_key, # required
      aws_secret_access_key: aws_secret# optional, defaults to nil
  }
  # config.fog_directory  = 'name_of_directory'                          # required
  # config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}"} # optional, defaults to {}
end