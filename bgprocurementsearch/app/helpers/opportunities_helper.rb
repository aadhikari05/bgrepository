module OpportunitiesHelper
  def sort_link(title, column, options = {})
    condition = options[:unless] if options.has_key?(:unless)
    sort_dir = params[:sort_d] == 'up' ? 'down' : 'up'
    sort_col = params[:sort_c]
    if(!sort_col.nil? && sort_col.to_s.eql?(column.to_s))
      title = sort_dir=='up' ?  title + image_tag("up.jpg", :border=>0):title + image_tag("down.jpg", :border=>0)
    end
    link_to_unless condition, title, request.parameters.merge( {:sort_c => column, :sort_d => sort_dir} )
  end
end
