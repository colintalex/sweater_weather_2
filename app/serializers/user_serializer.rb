class UserSerializer
    include JSONAPI::Serializer
    set_type :users
    attributes :id, :email, :api_key
end