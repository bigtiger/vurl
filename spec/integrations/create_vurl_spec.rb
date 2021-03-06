require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe "Create Vurls" do
  context "when successful" do
    before { submit_vurl 'http://veez.us' }
    it "redirects to the vurl stats page" do
      current_url.should == stats_url(Vurl.last.slug)
    end
    it "creates a vurl" do
      Vurl.last.url.should == 'http://veez.us'
    end
  end

  context "when unsuccessful" do
    before { submit_vurl 'whatthe?' }
    it "re-renders the new vurl page" do
      response.should render_template('vurls/new')
    end
    it "doesn't create a vurl" do
      Vurl.last.should be_nil
    end
  end
end

def submit_vurl url
  visit root_path
  fill_in "vurl_url", :with => url
  click_button 'Vurlify!'
end
