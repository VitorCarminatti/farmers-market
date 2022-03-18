class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def home
  end

  def get_products
    render json: { data: Product.all }
  end

  def totalize_products
    items = JSON.parse(params[:items])
    total = 0

    if items.present?
      items.to_a.each do |item|
        total += Product.find_by(code: item[0]).price * item[1]
      end

      total = BOGO(total, items['CF1']) if items['CF1'].present?
      total = APPL(total, items['AP1']) if items['AP1'].present? && items['AP1'] >= 3
      total = CHMK(total) if items['CH1'].present? && items['CH1'] >= 1
    end

    render json: { total: total }
  end

  def BOGO(total, cooffes)
    coofee_price = Product.find_by(code: 'CF1').price
    total - ((cooffes / 2) * coofee_price)
  end

  def APPL(total, apples)
    total - apples * 1.5
  end

  def CHMK(total)
    milk_price = Product.find_by(code: 'MK1').price
    total - milk_price
  end
end
