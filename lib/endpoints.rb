require 'json'

require_relative 'validation'

class Endpoints
    def self.timed_data(process, meta, uid)
        Validation.validate_timed_data(process, meta, uid)

        data = { 
            process: process,
            meta: meta,
            uid: uid 
        }
        
        return data.to_json
    end

    def self.metric_data(process, meta, items)
        Validation.validate_metric_data(process, meta, items)
        
        data = { 
            process: process,
            meta: meta,
            items: items 
        }

        return data.to_json
    end

    def self.exception_data(process, meta, exception_text)
        Validation.validate_exception_data(process, meta, exception_text)
        
        data = { 
            process: process,
            meta: meta,
            exception: exception_text 
        }
     
        return data.to_json
    end
end