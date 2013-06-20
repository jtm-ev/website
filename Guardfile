
guard 'livereload', :apply_js_live => false do
  watch(%r{app/.+\.(erb|haml|mustache)})
  watch(%r{app/helpers/.+\.rb})
  # watch(%r{(public/|app/assets).+\.(css|js|html)})
  watch(%r{(app/assets/.+)\.(coffee)}) { |m| "assets/#{m[1]}" }
  watch(%r{(app/assets/.+\.css)\.(s[ac]ss|styl|less)}) { |m| "assets/#{m[1]}" }
  watch(%r{(app/assets/.+\.css)}) { |m| "assets/#{m[1]}" }
  # watch(%r{(app/assets/.+\.js)\.coffee}) { |m| m[1] }
  watch(%r{config/locales/.+\.yml})
  
  # watch(%r{(brunch/build/web/css).+\.(css|js|html)})
  watch(%r{(brunch/build/web/js).+\.(css|js|html|mustache)})
end