module ApplicationHelper

  def svg(filename, options = {})
    assets = Rails.application.assets
    asset = assets.find_asset(filename)

    if asset
      file = asset.source.force_encoding('UTF-8')
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css 'svg'
      svg['class'] = options[:class] if options[:class]
      svg['width'] = options[:width] if options[:width]
      svg['height'] = options[:height] if options[:height]
    else
      doc = "<!-- SVG #{filename} not found -->"
    end

    raw doc
  end
end
