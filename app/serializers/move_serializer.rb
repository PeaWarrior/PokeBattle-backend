class MoveSerializer < ActiveModel::Serializer
    attributes :name, :types, :power, :priority, :accuracy, :damage, :text
end