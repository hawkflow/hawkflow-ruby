class HawkFlowMetricsException < StandardError
    @@docs_url = "Please see docs at https://docs.hawkflow.ai/integration/index.html"
    @@message = "@HawkflowMetrics missing items parameter. " + @@docs_url

    def initialize
        super(message)
    end
end
