class TaskSerializer < ActiveModel::Serializer
  attributes :id,
    :title,
    :body,
    :expiration,
    :completed_on,
    :position,
    :tag_list
end
