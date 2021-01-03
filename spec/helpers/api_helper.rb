module Helpers
  module ApiHelper
    def fixture_file_upload(file_name, mime)
      Rack::Test::UploadedFile.new(Rails.root.join(fixture_path, file_name), mime, true)
    end
  end
end
