module Topics
  class Create < Mutations::Command
    required do
      string :name
    end

    def execute
      Topic.create(name: name)
    end
end