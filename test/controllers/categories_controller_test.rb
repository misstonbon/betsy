require "test_helper"

  describe CategoriesController do

    it " Should get index" do

    end

    it " should redirect if user not logged in " do
      get new_category_path
      must_respond_with :redirect
    end

    it " Data should reflect newly created category" do

      end

    it " Should redirect after create" do

    end

    it " Should flash error, render template and not affect the data if failed " do

    end


    it " Should get a list of items for a secific category" do

    end

    it "  Should render 404 if category could not be found" do

    end

  end
