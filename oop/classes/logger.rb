# frozen_string_literal: true

module Logger
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    def log(message, from_class)
      @client = Elasticsearch::Client.new hosts: [
        { host: 'localhost',
          port: '9200',
          user: 'admin',
          password: 'admin',
          scheme: 'https' }
      ], transport_options: { ssl: { ca_file: '/Users/dolgashov-ds/Downloads/kirk.pem' } }

      @client.index index: 'logger', type: '_doc', body: { message: message, class: from_class }
    end
  end
end
