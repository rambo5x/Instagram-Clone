require 'rails_helper'

RSpec.describe "Posts", type: :request do
      before do
        @user = create(:user_with_posts)
        @post = @user.posts.first
        @other_user = create(:user_with_posts)
        @other_user_post = @other_user.posts.first
      end
    
     context "When signed in" do
       before do
          sign_in @user
       end
         
      it "should be able to view my own posts" do
        get user_posts_url(@user)
        expect(response).to have_http_status(:ok)
      end

      describe "creating my own post" do
        it "should be able to get new post form" do
          get new_user_post_url(@user)
          expect(response).to have_http_status(:ok)
        end

        it "should be able to create a valid post" do
          expect{
              post user_posts_url(@user), params: { post: { caption: "cool post", image_url: "http://aol.com/dog.jpg" } }
          }.to change(Post,:count).by 1

          expect(response).to redirect_to(user_posts_url(@user))
        end

        it "should not be able to create an invalid post" do
          expect{
            post user_posts_url(@user), params: { post: { caption: "cool post", image_url: "http://aol.com" } }
          }.not_to change(Post,:count)

          expect(response).to have_http_status(:ok)
        end
      end

      describe "updating my own post" do
        it "should be able to get edit" do
          get edit_user_post_url(@user,@post)
          expect(response).to have_http_status(:ok)
        end

        it "should be able to update post when valid" do
          patch user_post_url(@user, @post), params: { post: { image_url: "http://aol.com/cat.jpg", } }
          expect(response).to redirect_to(user_posts_url(@user))
        end

        it "should not be able to update post when invalid" do
          patch user_post_url(@user, @post), params: { post: { image_url: "http://aol.com/cat", } }
          expect(Post.find(@post.id).image_url).not_to eq("http://aol.com/cat")
          expect(response).to have_http_status(:ok)
        end
      end

      it "should show post" do
        get user_post_url(@user, @post)
        expect(response).to have_http_status(:ok)
      end

      it "should destroy post" do
        expect{
          delete user_post_url(@user, @post)
        }.to change(Post,:count).by -1

        expect(response).to redirect_to(user_posts_url(@user))
      end

      context "dealing with another user" do
        it "should get index" do
          get user_posts_url(@other_user)
          expect(response).to have_http_status(:ok)
        end
  
        it "should not get new" do
          get new_user_post_url(@other_user)
          expect(response).to redirect_to(root_path)
        end
  
        it "should not create post" do
          expect{
            post user_posts_url(@other_user), params: { post: { caption: "cool post", image_url: "http://aol.com/dog.jpg" } }
          }.not_to change(Post, :count)
          expect(response).to redirect_to(root_path)
        end
  
        it "should show post" do
          get user_post_url(@other_user, @other_user_post)
          expect(response).to have_http_status(:ok)
        end
  
        it "should not get edit" do
          get edit_user_post_url(@other_user, @other_user_post)
          expect(response).to redirect_to(root_path)
        end
  
        it "should not update post" do
          patch user_post_url(@other_user, @other_user_post), params: { post: { caption: "edited", image_url: "http://aol.com/cat.jpg" } }
          expect(Post.find(@other_user_post.id).image_url).not_to eq("http://aol.com/cat.jpg")
          expect(response).to redirect_to(root_path)
        end
  
        it "should not destroy post" do
          delete user_post_url(@other_user, @other_user_post)
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "when not signed in" do
      it "should not get index" do
        get user_posts_url(@user)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should not get new" do
        get new_user_post_url(@user)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should not create post" do
        expect{
          post user_posts_url(@user), params: { post: { caption: "cool post", image_url: "http://aol.com/dog.jpg" } }
        }.not_to change(Post, :count)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should not show post" do
        get user_post_url(@user, @post)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should not get edit" do
        get edit_user_post_url(@user, @post)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should not update post" do
        patch user_post_url(@user, @post), params: { post: { caption: "edited", image_url: "http://aol.com/cat.jpg" } }
        expect(Post.find(@post.id).image_url).not_to eq("http://aol.com/cat.jpg")
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should not destroy post" do
        delete user_post_url(@user, @post)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
end
