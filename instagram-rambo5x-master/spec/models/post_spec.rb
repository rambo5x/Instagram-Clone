require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = User.create(email: "bob@bob.com", password: "password123")
  end

  it "requires an image_url to be valid" do
    post = Post.new(image_url: nil, user_id: @user.id)
    
    #this post does not have an image_url, do we expect it to be valid?
    expect(post).not_to be_valid
  end

  it "requires a valid image_url to be valid" do
    post = Post.new(image_url: "http://www.google.com", user_id: @user.id)
    expect(post).not_to be_valid
  end

  it "requires a user_id to be valid" do
    post = Post.new(image_url: "http://www.google.com/dog.jpeg", user_id: nil)
    expect(post).not_to be_valid
  end

  it "is valid when given an image_url and user_id" do
    post = Post.new(image_url: "http://www.google.com/dog.jpeg", user_id: @user.id)
    expect(post).to be_valid
  end
end
