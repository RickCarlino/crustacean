module Topics
  class Create < Mutations::Command
    required do
      string :name
    end

    def execute
      raise """ Now, make an API that accepts something like this:
      {questions: {'name':    ['address', 'city'],
                   'address': ['city', 'name'],
                   'city':    ['name']}
      """
      Topic.create(name: name)
    end
  end
end