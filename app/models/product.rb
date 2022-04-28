class Product < ActiveRecord::Base
    has_one_attached :image
    validates :title, presence: true
    validates :image, attached: true
    belongs_to :user
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings


    # finds products with the associated tag
    def self.tagged_with(name)
        Tag.find_by!(name: name).products
    end

    # counts how many of a certain tag there are
    def self.tag_counts
        Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
    end

    # creates the tag list when creating the product to display associated tags
    def tag_list
        tags.map(&:name).join(', ')
    end

    # creates the tags associated with the product in the Tag table
    def tag_list=(names)
        self.tags = names.split(',').map do |n|
            Tag.where(name: n.strip).first_or_create!
        end
    end

end
