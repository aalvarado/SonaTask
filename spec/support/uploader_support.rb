module Support
  module UploaderSupport

    def self.included(klass)
      klass.send :remove_method, :store_dir
    end

    def store_dir
      "#{base_store_dir}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def base_store_dir
      "#{Rails.root}/tmp/uploads"
    end

    def clean_uploads
      if base_store_dir.present?
        Rails.logger.info "Cleaning uploads from #{base_store_dir}"
        FileUtils.rm_rf "#{base_store_dir}"
      end
    end

    module_function :base_store_dir, :clean_uploads
  end
end
