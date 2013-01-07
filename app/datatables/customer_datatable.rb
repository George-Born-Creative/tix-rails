
class CustomerDatatable
  delegate :params, :h, :link_to, :image_tag, :number_to_currency, to: :@view

  def initialize(view, current_account_id)
    @view = view
    @account = Account.find( current_account_id)
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @account.users.with_role(:customer).count,
      iTotalDisplayRecords: @account.users.with_role(:customer).count,
      aaData: data,
      sortColumn: sort_column,
      sortDirection: sort_direction
    }
  end

private

  def data
    # blank (for photo)
    # first_name
    # last_name 
    # yearly_sales (not yet implemented)

    
    customers.map do |customer|
      
      [
        link_to(customer.first_name, "/manager/users/#{customer.id.to_s}"),
        link_to(customer.last_name, "/manager/users/#{customer.id.to_s}"),
        link_to(customer.email, "/manager/users/#{customer.id.to_s}"),
        number_to_currency(customer.total_sales)     
      ]
    end
  end

  def customers
    @customers ||= fetch_customers
  end

  def fetch_customers
    
    if params[:sSearch].present?
      customers = @account.users
                          .with_role(:customer)
                          .where("lower(first_name || ' ' || last_name || ' ' || email) ILIKE :search",  search: "%#{params[:sSearch]}%")
                          .order("#{sort_column} #{sort_direction}").page(page).per(per_page)
                          
    else
      customers = @account.users.with_role(:customer)
                          .order("#{sort_column} #{sort_direction}").page(page).per(per_page)
      
                          
    end
    
    customers
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[first_name last_name]
    columns[params[:iSortCol_0].to_i]
    'first_name'
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end