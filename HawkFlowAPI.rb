require 'net/http'
require 'uri'
require 'json'

require_relative 'Endpoints'
require_relative 'Validation'

class HawkFlowAPI
    @@hawkFlowApiUrl = "https://api.hawkflow.ai/v1"
    @@max_retries = 3
    @@retry_count = 0
    @@success = false
    @@response = nil

    def self.metrics(process, meta, items, api_key = "")
        url = URI(hawkFlowApiUrl + "/metrics")
        Endpoints.metric_data(process, meta, items)
        hawkflow_post(url, data, api_key)
    end

    def self.exceptiom(process, meta, exception_text, api_key = "")
        url = URI(hawkFlowApiUrl + "/exception")
    end

    def self.start(process, meta, uid="", api_key = "")
        url = URI(hawkFlowApiUrl + "/timed/start")
    end

    def self.end(process, meta, uid="", api_key = "")
        url = URI(hawkFlowApiUrl + "/timed/end")
    end


    def self.hawkflow_post(url, data, api_key)
        begin
            Validation.validateApiKey(apiKey);

            while !success && retry_count < max_retries do
                begin
                    http = Net::HTTP.new(uri.host, uri.port)
                    request = Net::HTTP::Post.new(url)
                    request["Content-Type"] = "application/json"
                    request["hawkflow-api-key"] = api_key                                
                    request.body = data
                    response = http.request(request)
                    success = response.is_a?(Net::HTTPSuccess)                
                rescue Exception => e
                    retry_count += 1
                    puts "HawkFlowAPI Error: #{e.message}. Retrying..."
                    sleep 1
                end
            end

            if success
                json_response = JSON.parse(response.body)
        rescue Exception => e
            puts "Error: #{e.message}."            
        end
    end
end