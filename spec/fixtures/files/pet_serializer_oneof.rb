class PetSerializer < ActiveModel::Serializer
  attributes :id, :name, :animal, :tag


  def id
    required_check(:id)

    type_check(:id, [Integer])
    object.id
  end

  def name
    required_check(:name)

    type_check(:name, [String])
    object.name
  end

  def animal
    type_check(:animal, [
      Cat,
      Dog,
    ])
    one_of_animal(object.animal)
  end

  def tag
    type_check(:tag, [String])
    object.tag
  end

  private

  def required_check(name)
    raise "Required field is nil. #{name}" if object.send(name).nil?
  end

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end

  def one_of_animal(one_of_value)
    serializer = ActiveModelSerializers::SerializableResource.new(one_of_value).serializer
    raise "Undefined serializer one_of ref: #{one_of_value.class}" if serializer.nil?
    serializer.new(one_of_value)
  end
end
