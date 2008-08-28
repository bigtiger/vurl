class Vurl < ActiveRecord::Base
  validates_presence_of :url
  validates_format_of   :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

  def before_save
    if vurl = Vurl.find(:first, :order => 'slug DESC')
      self.slug = vurl.slug.succ
    else
      self.slug = 'AAAA'
    end
  end
end