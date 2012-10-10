class ArtistDatatable
  delegate :params, :h, :link_to, :image_tag, :number_to_currency, to: :@view

  def initialize(view, current_account_id)
    @view = view
    @account = Account.find current_account_id
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @account.artists.count,
      iTotalDisplayRecords: artists.count,
      aaData: data,
      sortColumn: sort_column,
      sortDirection: sort_direction,
    }
  end

private

  def data
    artists.map do |artist|      
      [
        link_to(image_tag(artist.photo(:thumb)), artist),
        artist.name,
        (artist.twitter ? link_to(' Twitter ', artist.twitter) : nil ),
        (artist.facebook_url ? link_to(' Facebook ', artist.facebook_url) : nil),
        (artist.video_url ? link_to(' Video ', artist.video_url) : nil),
        (artist.url ? link_to(' Website ', artist.url) : nil),
        link_to('Edit', artist, :class => 'btn')
      ]
    end
  end

  def artists
    @artists ||= fetch_artists
  end

  def fetch_artists    
    artists = @account.artists.order("#{sort_column} #{sort_direction}").page(page).per(per_page)
    
    if params[:sSearch].present?
      artists = artists.where("name like :search", search: "%#{params[:sSearch]}%")
    end
    
    artists
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name]
    columns[params[:iSortCol_0].to_i]
    'name'
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end