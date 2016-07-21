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
    if published_changed? and published.eql?(true)
      puts "##### Callback Fired"
      # except this update all to unpublished and editing false
      app.versions.update_all(published: false, editing: false, published_at: nil)
      # set published time to now
      self.published_at = Time.now
      self.editing = false
      self.published = true
      count = app.versions.count + 1
      # then create a new version(i.e editing one) unless editing version exists
      unless app.versions.where(number: count).exists?
        app.versions.create(number: count, editing: true)
        #TODO create app templates with newly generated version
      end
    end
  end



end
