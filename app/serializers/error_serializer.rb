class ErrorSerializer
    include JSONAPI::Serializer
    set_id { |id| id = nil }
    set_type :error
    attributes :description
end