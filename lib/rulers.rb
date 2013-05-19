require "rulers/version"
require "rulers/routing"
require "rulers/array"
require "rulers/file_utilities"

module Rulers
  class Application
    include Rulers::FileUtilities

    def call env
      if env['PATH_INFO'] == '/favicon.ico'
        return [404,
                {'Content-Type' => 'text/html'}, []]
      end
      if env['PATH_INFO'] == '/'
        page_content = file_to_text "public/index.html"
        return [200,
                {'Content-Type' => 'text/html'}, [page_content]]
      end
      if env['PATH_INFO'] == '/redirect'
        return [302,
                {'Content-Type' => 'text', 'Location' => "home"}, ["302 not found"]]
      end
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send get_action act
        status = 200
      rescue
        text = "Ups!! error in app"
        status = 500
      end
      [status,
       {'Content-Type' => 'text/html'}, [text]]
    end

    private

    def get_action act
      (act.nil? or act == "") ? "index" : act
    end


  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end

  end

end
