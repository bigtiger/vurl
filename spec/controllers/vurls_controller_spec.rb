require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VurlsController do
  integrate_views

  describe "when displaying an index of vurls" do
    it "should redirect when the index action is called" do
      get :index
      response.should be_redirect
    end
    it "should redirect to the new vurl page" do
      get :index
      response.should redirect_to(new_vurl_url)
    end
  end

  describe "when editing a vurl" do
    before(:each) do
      @vurl = Factory(:vurl)
      get :edit, :id => @vurl.id
    end
    it "should redirect when the edit action is called" do
      response.should be_redirect
    end
    it "should redirect to the new vurl page" do
      response.should redirect_to(new_vurl_url)
    end
    it "should redirect when the update action is called" do
      post :update, :id => @vurl.id
      response.should redirect_to new_vurl_path
    end
  end

  describe "when destroying vurls" do
    it "should redirect to the new vurls path" do
      post :destroy, :id => Factory.create(:vurl).id
      response.should redirect_to(new_vurl_path)
    end
  end

  describe "when showing vurls" do
    it "should render the show action" do
      vurl = Factory(:vurl)
      get :show, :id => vurl.id
      response.should render_template(:show)
    end
  end

  describe "when creating vurls" do
    it "should render the new form" do
      get :new
      response.should render_template(:new)
    end
    it "should redirect to the show page" do
      vurl = Factory(:vurl)
      post :create, :id => vurl.id, :vurl => {:url => vurl.url}
      #FIXME Incrementing vurl.id feels wrong
      response.should redirect_to(vurl_url(Factory.build(:vurl, :id => vurl.id+1)))
    end
  end

  describe "when previewing vurls" do
    it "should render the preview form" do
      vurl = Factory(:vurl)
      get "/p/#{vurl.slug}"
      #get preview_url(vurl)
      response.should render_template(:preview)
    end
  end
end