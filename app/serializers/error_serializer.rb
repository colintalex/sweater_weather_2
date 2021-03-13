class ErrorSerializer
    include JSONAPI::Serializer
    attributes :description
    set_id { |id| id = nil }
end