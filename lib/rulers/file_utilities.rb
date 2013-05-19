module Rulers
  module FileUtilities

    def file_to_text(file_name)
      directory, page = file_name.split('/', 2)
      to_open = File.join(directory, page)
      File.open(to_open).read
    end

  end
end