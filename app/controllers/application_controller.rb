class ApplicationController < ActionController::Base
  protect_from_forgery

  CONFIGURED_SITES = %W{ mariaysasi.com ferroea.com claquetitas.com goldenratio.me ladespensademorille.es }

  before_filter :set_site

  protected

  def set_site
    if request.host =~ /^www\.(.*)$/
      redirect_to 'http://' + $1 and return false
    end
    unless CONFIGURED_SITES.include?(request.host)
      render_404 and return false
    else
      if request.path == '/'
        render :text => File.read("#{Rails.root}/public/#{request.host}/index.html") and return
      else

      end
    end

  end

  def render_404
    render :file => "public/404.html.erb", :status => 404, :layout => false
  end

end
