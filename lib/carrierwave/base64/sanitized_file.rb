module CarrierWave
  class SanitizedFile
    alias_method :old_file=, :file=

    def file= file
      if file.is_a?(Hash) && file['data']
        self.instance_variable_set(:@original_filename, file['filename']) if @original_filename.blank?
        file['tempfile'] = buffer_decode64(file['data'])
      end

      self.old_file = file
    end

    private

    def buffer_decode64 buffer
      StringIO.new(::Base64.decode64( buffer ))
    end
  end
end
