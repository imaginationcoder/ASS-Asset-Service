class Version
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Paranoia

  ## Fields ---------------------------------------------- ###
  field :number , type: Integer
  field :editing, type: Boolean, default: true
  field :published, type: Boolean, default: false
  field :published_at, type: Time, default: nil

  ## validations  ---------------------------------------- ###
  validates :number, presence: true, uniqueness: true

  ## Associations  ---------------------------------------- ###
  embedded_in :app



  # after publish update published=> true and editing=> false and create another version with count+1(unless same version exists)
  # and create all templates with new version(editing one)
  before_update :check_if_published


  private
  def check_if_published
    # self.published_changed?(from: false, to: true)
    if self.published_changed? and self.published.eql?(true)
      app_versions = self.app.versions
      # set published time to now
      self.published_at = Time.now
      self.editing = false
      # except this update all to unpublished and editing false
      app_versions.where(:id.ne => self.id).update(published: false, editing: false)
      count = app_versions.count + 1
      # then create a new version(i.e editing one) unless editing version exists
      unless app_versions.where(number: count).exists?
        app_versions.create(number: count)
        #TODO create app templates with newly generated version
      end
    end
  end



end
