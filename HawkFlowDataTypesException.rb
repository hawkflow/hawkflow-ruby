class HawkFlowDataTypesException < StandardError
    @@docs_url = "Please see docs at https://docs.hawkflow.ai/integration/index.html";
    @@message = "HawkFlow data types not set correctly. " + docs_url

    def initialize(error_message)
        super(error_message + " " + message)
    end
end