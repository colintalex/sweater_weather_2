class BackgroundImage
    attr_reader :id, :image
    def initialize(data)
        @image = set_image(data)
    end

    def set_image(data)
        {
            location: data[:location],
            image_url: data[:urls][:full],
            credit: {
                author: data[:user][:username],
                logo: 'nil',
                source: 'unsplash'
            }
        }
    end
end