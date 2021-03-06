module TestTrack
  class AnalyticsEvent
    attr_reader :visitor_id, :assignment

    def initialize(visitor_id, assignment)
      @visitor_id = visitor_id
      @assignment = assignment
    end

    def name
      if assignment.feature_gate?
        'feature_gate_experienced'
      else
        'split_assigned'
      end
    end

    def properties
      {
        test_track_visitor_id: visitor_id,
        split_name: assignment.split_name,
        split_variant: assignment.variant,
        split_context: assignment.context
      }
    end
  end
end
