require 'net/http'
require 'uri'
require 'json'

require_relative 'endpoints'
require_relative 'validation'

class HawkFlowClient
    @@hawkFlowApiUrl = "https://api.hawkflow.ai/v1"

    def initialize(api_key="", max_retries=3, wait_time=0.1)
        @api_key = api_key
        @max_retries = max_retries
        @wait_time = wait_time
    end

    def metrics(process, meta, items)
        url = URI(@@hawkFlowApiUrl + "/metrics")
        data = Endpoints.metric_data(process, meta, items)
        hawkflow_post(url, data)
    end

    def exceptiom(process, meta, exception_text)
        url = URI(@@hawkFlowApiUrl + "/exception")
        data = Endpoints.exception_data(process, meta, exception_text)
        hawkflow_post(url, data)
    end

    def start(process, meta, uid="")
        url = URI(@@hawkFlowApiUrl + "/timed/start")
        data = Endpoints.timed_data(process, meta, uid)
        hawkflow_post(url, data)
    end

    def end(process, meta, uid="")
        url = URI(@@hawkFlowApiUrl + "/timed/end")
        data = Endpoints.timed_data(process, meta, uid)
        hawkflow_post(url, data)
    end

    def hawkflow_post(url, data)
        begin
            @api_key = Validation.validate_api_key(@api_key)
            
            retry_count = 0
            success = false
            response = nil

            while !success && retry_count < @max_retries do
                begin
                    http = Net::HTTP.new(uri.host, uri.port)
                    request = Net::HTTP::Post.new(url)
                    request["Content-Type"] = "application/json"
                    request["hawkflow-api-key"] = @api_key                                
                    request.body = data
                    response = http.request(request)
                    success = response.is_a?(Net::HTTPSuccess)                
                rescue Exception => e
                    retry_count += 1
                    puts "HawkFlowAPI Error: #{e.message}. Retrying..."
                    sleep @wait_time
                end
            end

            if success
                json_response = JSON.parse(response.body)
            end
        rescue Exception => e
            puts "Error: #{e.message}."            
        end
    end
end