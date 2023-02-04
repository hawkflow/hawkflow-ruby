require 'json'

require_relative 'Validation'

class Endpoints
    def self.timed_data(process, meta, uid)
        Validation.validateTimedData(process, meta, uid)

        data = { 
            process: process,
            meta: meta,
            uid: uid 
        }
        
        return data.to_json
    end

    def self.metric_data(process, meta, items)
        Validation.validateMetricData(process, meta, items)
        
        data = { 
            process: process,
            meta: meta,
            items: items 
        }

        return data.to_json
    end

    def self.exception_data(process, meta, exception_text)
        Validation.validateExceptionData(process, meta, exception_text)
        
        data = { 
            process: process,
            meta: meta,
            exception: exception_text 
        }
     
        return data.to_json
    end
end