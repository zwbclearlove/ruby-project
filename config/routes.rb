Rails.application.routes.draw do
  resources :follows
  resources :messages
  resources :comments
  resources :product_types
  resources :products
  resources :shops
  resources :sellers
  resources :favorites
  resources :cart_items
  resources :order_items
  resources :orders
  resources :addresses
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # user part
  get 'user_info', to: 'user_views#user_info'
  get 'user_image_update', to: 'user_views#user_image_update'
  post 'do_user_image_update', to: 'user_views#do_user_info_update'
  get 'login', to: 'user_views#login'
  post 'do_login', to: 'user_views#do_login'
  get 'register', to: 'user_views#register'
  post 'do_register', to: 'user_views#do_register'
  get 'logout', to: 'user_views#logout'
  get 'add_to_cart/:id', to: 'user_views#add_to_cart', as: :add_to_cart
  get 'cart', to: 'user_views#cart', as: :my_cart
  get 'add_cart_num/:id', to: 'user_views#add_cart_num', as: :add_cart_num
  get 'decrease_cart_num/:id', to: 'user_views#decrease_cart_num', as: :decrease_cart_num
  get 'follow/:id', to: 'user_views#follow', as: :follow_shop
  get 'unfollow/:id', to: 'user_views#unfollow', as: :unfollow_shop
  get 'my_favorites', to: 'user_views#favorites', as: :user_favorites
  get 'favorite/:id', to: 'user_views#favorite', as: :favorite_product
  get 'unfavorite/:id', to: 'user_views#unfavorite', as: :unfavorite_product
  get 'product/:id', to: 'user_views#product', as: :user_product
  get 'checkout', to: 'user_views#checkout', as: :user_checkout
  post 'gen_order', to: 'user_views#gen_order', as: :user_gen_order
  get 'place_order_success', to: 'user_views#place_order_success', as: :place_order_success
  get 'my_orders/:order_status', to: 'user_views#my_orders', as: :my_orders
  get 'receive/:order_id', to: 'user_views#receive_product', as: :receive_product
  post 'user_comment/:pid', to: 'user_views#comment', as: :user_comment
  get 'finish_order/:order_id', to: 'user_views#finish_order', as: :finish_order
  get 'my_messages', to: 'user_views#my_messages', as: :my_messages
  get 'delete_message/:id', to: 'user_views#my_message_delete', as: :user_message_delete
  get 'shop_info/:id', to: 'user_views#shop_info', as: :user_shop_info
  get 'system_detail', to: 'user_views#system_detail'
  get 'clear', to: 'user_views#database_clear'

  # shop part
  get 'shop', to: 'shop_views#shop_info', as: :shop_root
  get 'shop/login', to: 'shop_views#login'
  post 'shop/do_login', to: 'shop_views#do_login'
  get 'shop/register', to: 'shop_views#register'
  post 'shop/do_register', to: 'shop_views#do_register'
  get 'shop/logout', to: 'shop_views#logout'
  get 'shop/shop_register', to: 'shop_views#shop_register'
  post 'shop/do_shop_register', to: 'shop_views#do_shop_register'
  get 'shop/info', to: 'shop_views#shop_info'
  get 'shop/product_list', to: 'shop_views#product_list'
  post 'shop/add_product', to: 'shop_views#add_product'
  get 'shop/product_type', to: 'shop_views#product_types'
  get 'shop/show/:id', to: 'shop_views#product', as: :show_product
  get 'shop/orders/:order_status', to: 'shop_views#my_orders', as: :shop_orders
  get 'shop/my_messages', to: 'shop_views#my_messages', as: :shop_messages
  get 'shop/ship_product/:order_id', to: 'shop_views#ship_product', as: :ship_product
  get 'shop/urge_comment/:order_id', to: 'shop_views#urge_comment', as: :urge_comment
  get 'shop/product_image_update/:id', to: 'shop_views#product_image_update', as: :product_image_update
  post 'shop/do_product_image_update/:id', to: 'shop_views#do_product_image_update', as: :do_product_image_update
  get 'shop/shop_image_update', to: 'shop_views#shop_image_update'
  post 'shop/do_shop_image_update', to: 'shop_views#do_shop_image_update'


  root to: "user_views#index"
end
