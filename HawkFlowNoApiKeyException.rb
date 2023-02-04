class HawkFlowNoApiKeyException < StandardError
    @@docs_url = "Please see docs at https://docs.hawkflow.ai/integration/index.html"
    @@message = "No HawkFlow API Key set. " + docs_url

    def initialize()
        super(message)
    end
end