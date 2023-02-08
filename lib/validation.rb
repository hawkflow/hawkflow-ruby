require_relative 'hawkflow_api_key_format_exception'
require_relative 'hawkflow_no_api_key_exception'
require_relative 'hawkflow_metrics_exception'
require_relative 'hawkflow_data_types_exception'

class Validation
    @@pattern = /\A[a-zA-Z0-9_-]+\z/

    def self.validate_api_key(api_key)
        if api_key.nil? || api_key == ""
            api_key = ENV['HAWKFLOW_API_KEY']
        end

        if !api_key.is_a?(String)
            raise HawkFlowNoApiKeyException.new
        end

        if api_key =~ pattern
            if api_key.length > 50
                raise HawkFlowApiKeyFormatException.new
            end
        else
            raise HawkFlowApiKeyFormatException.new
        end

        return api_key
    end
  
    def self.validate_timed_data(process, meta, uid)
        validate_core(process, meta)
        validate_uid(uid)
    end

    def self.validate_metric_data(process, meta, items)
        validate_core(process, meta)
        validate_metric_items(items)
    end

    def self.validate_exception_data(process, meta, exception_text)
        validate_core(process, meta)
        validate_exception_text(exception_text)
    end

    def self.validate_core(process, meta)
        validate_process(process)
        validate_meta(meta)
    end

    def self.validate_process(process)
        if !process.is_a?(String)
            raise HawkFlowDataTypesException.new("HawkFlow API process parameter incorrect format.")
        end

        if process =~ pattern
            if process.length > 249
                raise HawkFlowDataTypesException.new("HawkFlow API process parameter exceeded max length of 250.")
            end
        else
            raise HawkFlowDataTypesException.new("HawkFlow API process parameter incorrect format.")
        end
    end

    def self.validate_meta(meta)
        if !meta.is_a?(String)
            raise HawkFlowDataTypesException.new("HawkFlow API meta parameter incorrect format.")
        end

        if meta =~ pattern
            if meta.length > 499
                raise HawkFlowDataTypesException.new("HawkFlow API meta parameter exceeded max length of 500.")
            end
        else
            raise HawkFlowDataTypesException.new("HawkFlow API meta parameter incorrect format.")
        end
    end

    def self.validate_uid(uid)
        if !uid.is_a?(String)
            raise HawkFlowDataTypesException.new("HawkFlow API uid parameter incorrect format.")
        end

        if uid =~ pattern
            if uid.length > 50
                raise HawkFlowDataTypesException.new("HawkFlow API uid parameter exceeded max length of 50.")
            end
        else
            raise HawkFlowDataTypesException.new("HawkFlow API uid parameter incorrect format.")
        end
    end

    def self.validate_exception_text(exception_text)
        if !exception_text.is_a?(String)
            raise HawkFlowDataTypesException.new("HawkFlow API exception_text parameter incorrect format.")
        end

        if exception_text.length > 15000
            raise HawkFlowDataTypesException.new("HawkFlow API exception_text parameter exceeded max length of 15000.")
        end
    end

    def self.validate_metric_items(items)
        if items.is_a?(Array) && items.all? { |hash| hash.is_a?(Hash) && hash.all? { |key, value| key.is_a?(String) && value.is_a?(Float) } }
            items.each do |hash|
                if hash[:name] != "name"
                    raise HawkFlowDataTypesException.new("HawkFlow API metric items parameter hash key must be called 'name'.")
                end

                if hash[:name] =~ pattern
                    if hash[:name].length > 50
                        raise HawkFlowDataTypesException.new("HawkFlow API metric items parameter name exceeded max length of 50.")
                    end
                else
                    raise HawkFlowDataTypesException.new("HawkFlow API metric items parameter name is in incorrect format.")
                end
            end
        else
            raise HawkFlowDataTypesException.new("HawkFlow API metric items parameter must be an array of hashes where the hash is of type { String => float }.")
        end        
    end
end
