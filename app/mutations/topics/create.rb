module Topics
  class Create < Mutations::Command
    required do
      string :name
      hash   :questions do
        array :*, arrayize: true
      end
    end

    def validate
    end

    def execute
      @topic
    end
  end
end