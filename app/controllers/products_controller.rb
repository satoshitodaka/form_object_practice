class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product_registration_form = ProductRegistrationForm.new
  end

  def create
    @product_registration_form = ProductRegistrationForm.new(product_registration_form_params)

    if @product_registration_form.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_registration_form_params
    params
      .require(:product_registration_form)
        .permit( products_attributes: Forms::Product::REGISTRABLE_ATTRIBUTES)
  end
end
