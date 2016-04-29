module Spree
  ProductsHelper.class_eval do
    def cache_key_for_products
      count = @products.try(:count)
      max_updated_at = (@products.try(:maximum, :updated_at) || Date.today).to_s(:number)
      "#{I18n.locale}/#{current_currency}/spree/products/all-#{params[:page]}-#{max_updated_at}-#{count}-#{Spree::Config[:theme_name]}-#{Spree::Taxon.pluck(:is_featured).to_sentence}"
    end

    def cache_key_for_taxons
      max_updated_at = @taxons.maximum(:updated_at).to_i
      parts = [@taxon.try(:id), max_updated_at].compact.join("-")
      "#{I18n.locale}/taxons/#{parts}/#{Spree::Config[:theme_name]}"
    end
  end
end
