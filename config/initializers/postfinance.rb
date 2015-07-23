ENV.update YAML.load_file('config/postfinance.yml')[Rails.env] rescue {}
