class Post < ApplicationRecord
    belongs_to :user
    #here the format is validating only WHEN an image_url is passed, but if not then it is not validated
    validates_format_of :image_url, :with => %r{(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?(gif|jpg|png|jpeg|bmp)$)}ix, :message => 'must be a URL for GIF, JPG, PNG, JPEG, or BMP image'
    #HW: add a validator to make an image_url required
    validates_presence_of :image_url
end
