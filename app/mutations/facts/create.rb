module Facts
  class Create < Mutations::Command
    required do
      model :topic
      model :user
    end
  end
end