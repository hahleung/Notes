module View
  class Picture
    def self.welcome(doc)
      doc.img :class => "img-thumbnail", :style => standard_size, :src => "https://i.ytimg.com/vi/X30BS3x-E_w/maxresdefault.jpg"
    end

    def self.error(doc)
      doc.img :class => "img-thumbnail", :style => standard_size, :src => "https://1098.fr/wp-content/uploads/2014/01/leonardo_di_caprio_inception-300x300.jpg"
    end

    def self.enigma(doc)
      doc.img :class => "img-thumbnail", :style => standard_size, :src => "http://home.bt.com/images/turing-bombe-136399065494703901-150706144229.jpg"
    end

    def self.success(doc)
      doc.img :class => "img-thumbnail", :style => standard_size, :src => "https://cdn0.vox-cdn.com/thumbor/bp8uy9d3XUfdgg6yUVR2h_vQ3FE=/0x0:728x410/1280x720/cdn0.vox-cdn.com/uploads/chorus_image/image/47616175/meaning-of-vault-boy-thumbs-up.0.0.jpg"
    end

    def self.standard_size
      "width:auto; height:auto; max-width:250px; display:block; margin-left:auto; margin-right:auto"
    end
  end
end

