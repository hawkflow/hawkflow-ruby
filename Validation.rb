require_relative 'HawkFlowApiKeyFormatException'
require_relative 'HawkFlowNoApiKeyException'
require_relative 'HawkFlowMetricsException'
require_relative 'HawkFlowDataTypesException'

class Validation
    @@pattern = /\A[a-zA-Z0-9_-]+\z/

    def self.validateApiKey(api_key)
        if api_key.nil? || api == ""
            api_key = ENV['HAWKFLOW_API_KEY']

        if !api_key.is_a?(String)
            raise HawkFlowNoApiKeyException.new()

        if api_key =~ pattern
            if api_key.length > 50
                raise HawkFlowApiKeyFormatException.new()
        else
            raise HawkFlowApiKeyFormatException.new()
        end
    end
  
    def self.validateTimedData(process, meta, uid)
        validateCore(process, meta)
        validateUid(uid)
    end

    def self.validateMetricData(process, meta, items)
        validateCore(process, meta)
        validateMetricItems(items)
    end

    def self.validateExceptionData(process, meta, exception_text)
        validateCore(process, meta)
        validateExceptionText(exceptionText)
    end

    def self.validateCore(process, meta)
        validateProcess(process);
        validateMeta(meta);
    end

    def self.validateProcess(process)
        if !process.is_a?(String)
            raise HawkFlowDataTypesException.new("HawkFlow API process parameter incorrect format.")

        if process =~ pattern
            if process.length > 249
                raise HawkFlowDataTypesException.new("HawkFlow API process parameter exceeded max length of 250.")
        else
            raise HawkFlowDataTypesException.new("HawkFlow API process parameter incorrect format.")
        end
    end

    def self.validateMeta(meta)
        if !meta.is_a?(String)
            raise HawkFlowDataTypesException.new("HawkFlow API meta parameter incorrect format.")

        if meta =~ pattern
            if meta.length > 499
                raise HawkFlowDataTypesException.new("HawkFlow API meta parameter exceeded max length of 500.")
        else
            raise HawkFlowDataTypesException.new("HawkFlow API meta parameter incorrect format.")
        end
    end

    def self.validateUid(uid)
        if !uid.is_a?(String)
            raise HawkFlowDataTypesException.new("HawkFlow API uid parameter incorrect format.")

        if uid =~ pattern
            if uid.length > 50
                raise HawkFlowDataTypesException.new("HawkFlow API uid parameter exceeded max length of 50.")
        else
            raise HawkFlowDataTypesException.new("HawkFlow API uid parameter incorrect format.")
        end
    end

    def self.validateExceptionText(exception_text)
        if !exception_text.is_a?(String)
            raise HawkFlowDataTypesException.new("HawkFlow API exception_text parameter incorrect format.")

        if exception_text.length > 15000
            raise HawkFlowDataTypesException.new("HawkFlow API exception_text parameter exceeded max length of 15000.")
    end

    def self.validateMetricItems(items)
        if items.is_a?(Array) && items.all? { |hash| hash.is_a?(Hash) && hash.all? { |key, value| key.is_a?(String) && value.is_a?(Float) } }
            array.each do |hash|
                if hash[:name] != "name"
                    raise HawkFlowDataTypesException.new("HawkFlow API metric items parameter hash key must be called 'name'.")

                if hash[:name] =~ pattern
                    if hash[:name].length > 50
                        raise HawkFlowDataTypesException.new("HawkFlow API metric items parameter name exceeded max length of 50.")
                else
                    raise HawkFlowDataTypesException.new("HawkFlow API metric items parameter name is in incorrect format.")
                end
            end
        else
            raise HawkFlowDataTypesException.new("HawkFlow API metric items parameter must be an array of hashes where the hash is of type { String => float }.")
        end        
    end
end