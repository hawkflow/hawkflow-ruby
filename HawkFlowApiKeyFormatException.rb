class HawkFlowApiKeyFormatException < StandardError
    @@docs_url = "Please see docs at https://docs.hawkflow.ai/integration/index.html"
    @@message = "HawkFlow API Invalid API Key format. " + docs_url

    def initialize()
        super(message)
    end
end