module Reviews
  class Update < Mutations::Command
    required do
      model :review
      model :user
      array :proposed, class: String
    end

    def execute
      ensure_ownership
      mark_response
      # TODO Use more consistant response. I don't like
      # multiple obj. representations in an API.
      {proposed: proposed.sort,
       actual:review.correct_answers,
       success: is_correct?}
    end

    def mark_response
      is_correct? ? review.mark_correct! : review.mark_incorrect!
    end

    def ensure_ownership
      add_error(:user, :unauthorized, "Not yours to review.") unless is_owner?
    end

private

    def is_owner?
      review.owner == user
    end

    def is_correct?
      proposed.sort == review.correct_answers
    end
  end
end