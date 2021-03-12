class BackgroundImageSerializer
    include JSONAPI::Serializer
    set_type :image  # optional
    attributes :image
end