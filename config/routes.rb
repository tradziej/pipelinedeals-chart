# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    get 'deals/index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
