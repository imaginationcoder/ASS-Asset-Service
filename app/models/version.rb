class Version
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## Fields ---------------------------------------------- ###
  field :number , type: Integer
  field :editing, type: Boolean, default: true
  field :published, type: Boolean, default: false
  field :published_at, type: Time, default: nil

  ## validations  ---------------------------------------- ###
  validates :number, presence: true, uniqueness: true

  ## Associations  ---------------------------------------- ###
  embedded_in :app

  before_update :if_published_create_version_and_templates

  private
  # before publishing version, update editing and published attrs for other versions
  # and create a new version if doesn't exists and create templates for newly generated version
  def if_published_create_version_and_templates
    if published_changed? and published.eql?(true)
      # except this update all to unpublished and editing false
      app.versions.update_all(published: false, published_at: nil)
      count = app.versions.count + 1
      # set published time to now
      self.published_at = Time.now
      self.published = true
      #self.editing = false
      # then create a new version(i.e editing one) unless editing version exists
      if self.editing.eql?(true)
        app.versions.update(editing: false)
        self.editing = false
        new_version = app.versions.create(number: count, editing: true)
        # Now create app templates with newly generated version by cloning previous version's templates
        app.templates.where(app_version: new_version.number - 1).each do |template|
          cloned_template = template.clone
          cloned_template.via_publishing = true
          cloned_template.app_version = new_version.number # update app_version with newly generated one
          # Set timestamps to nil so that new timestamps are added when saved
          cloned_template.created_at = nil;cloned_template.updated_at = nil
          # copy source of original template to cloned template
          CopyCarrierwaveFile::CopyFileService.new(template, cloned_template, :source).set_file if template.source.url
          cloned_template.text_assets.each  {|ts| ts.created_at = nil;ts.updated_at = nil }
          cloned_template.button_actions.each_with_index do |bc, index|
            bc.created_at = nil; bc.updated_at = nil
            if template.button_actions[index].btn_type.eql?(2)
              CopyCarrierwaveFile::CopyFileService.new(template.button_actions[index], bc, :source).set_file if template.button_actions[index].source.url
            end
          end
          cloned_template.save
        end
      end
    end
  end



end
