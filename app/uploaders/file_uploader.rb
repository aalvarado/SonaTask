class FileUploader < CarrierWave::Uploader::Base
  storage :file

  UPLOAD_DIR = 'uploads'

  def extension_white_list
    [
      image_white_list,
      document_white_list,
      archive_white_list
    ].reduce(&:+)
  end

  def image_white_list
    %w(jpg jpeg gif png svg)
  end

  def document_white_list
    %w(
      txt
      pdf
      odf
      doc docx
      xls xslx
      ppt pptx
      ods
      odt
      odp
      odg
      html
      csv
      md
    )
  end

  def archive_white_list
    %w(
      zip
      tar
      7z
    )
  end

  def store_dir
    "#{UPLOAD_DIR}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "tmp/uploads"
  end
end

