class CustomerImportsController < ApplicationController
  respond_to :json, :html

  def index
    @customer_imports = @current_account.customer_imports.all

    respond_with @customer_imports
  end

  def show
    @customer_import = @current_account.customer_imports.find(params[:id])

    respond_with @customer_import
  end
  
  def new
    @customer_import = @current_account.customer_imports.new
    

    respond_with @customer_import
  end

  def edit
    @customer_import = @current_account.customer_imports.find(params[:id])
  end

  def create
    @customer_import = @current_account.customer_imports.new(params[:customer_import])

    respond_to do |format|
      if @customer_import.save
        format.html { redirect_to customer_imports_path, notice: 'Queued' }
        format.json { render json: @customer_import, status: :created, location: @customer_import }
      else
        format.html { redirect_to customer_imports_path, notice: 'Error' }
        format.json { render json: @customer_import.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   @customer_import = @current_account.customer_imports.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @customer_import.update_attributes(params[:customer_import])
  #       format.html { redirect_to @customer_import, notice: 'Customer Import was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @customer_import.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /customer_imports/1
  # DELETE /customer_imports/1.json
  # def destroy
  #   @customer_import = @current_account.customer_imports.find(params[:id])
  #   @customer_import.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to customer_imports_url }
  #     format.json { head :no_content }
  #   end
  # end
end
