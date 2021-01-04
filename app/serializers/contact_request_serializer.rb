class ContactRequestSerializer < ActiveModel::Serializer
  attributes ContactRequest.attribute_names
end
