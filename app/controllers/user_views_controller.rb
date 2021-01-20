class UserViewsController < ApplicationController
  before_action :authenticate, only: [:favorites, :my_messages, :cart, :favorite, :add_to_cart, :follow, :comment]

  def login
  end

  def do_login
    print(params)
    user = User.where(username: params[:username], password: params[:password]).first
    if user
      session[:current_userid] = user.id
      session[:current_username] = user.username
      redirect_to root_url, notice: '用户登录成功。' and return
    else
      redirect_to login_path, alert: '用户名或密码错误。' and return
    end
  end

  def register
  end

  def do_register
    username = params[:username]
    email = params[:email]
    password = params[:password]
    password_confirm = params[:password_confirm]

    print(username)
    print(email)
    print(password)
    print(password_confirm)
    if username.empty? or email.empty? or password.empty? or password_confirm.empty?
      redirect_to register_url, alert: '信息不能为空。' and return
    end
    user = User.where(username:username).first
    print(user)
    if user
      redirect_to register_url, alert: '用户名已经存在。' and return
    end
    unless password_confirm == password
      redirect_to register_url, alert: '密码不匹配。' and return
    end
    user = User.new
    user.username = username
    user.email = email
    user.password = password
    user.nickname = 'user' + rand(9999).to_s
    user.image = 'default_avatar.png'
    user.save
    redirect_to login_path, notice: '注册成功，请登录。'
  end

  def logout
    session.delete(:current_userid)
    redirect_to login_path, alert: '用户成功登出。'
  end

  def index
    @products = Product.all
    user_id = session[:current_userid]
    @pro_fav = {}
    for product in @products
      fav = Favorite.where(user_id: user_id, product_id: product.id).first
      if fav
        @pro_fav[product.id] = true
      else
        @pro_fav[product.id] = false
      end
    end
  end

  def user_info
    user_id = session[:current_userid]
    @user = User.where(id:user_id).first
    @addresses = Address.where(user: @user)
    @image = @user.image.nil?
  end

  def user_image_update
    user_id = session[:current_userid]
    @user = User.where(id:user_id).first
    render 'image_update'
  end

  def do_user_info_update
    user_id = session[:current_userid]
    @user = User.where(id:user_id).first
    uploaded_file = params[:picture]
    File.open(Rails.root.join('app', 'assets', 'images', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end
    puts uploaded_file
    @user.image = uploaded_file.original_filename
    @user.save
    redirect_to user_info_path, notice: '头像修改成功。'
  end

  def add_to_cart
    user_id = session[:current_userid]
    product = Product.find(params[:id])
    cart_item = CartItem.where(user_id:user_id, product_id:product.id).first
    if cart_item
      cart_item.product_number += 1
      cart_item.save
    else
      cart_item = CartItem.new
      cart_item.product_name = product.name
      cart_item.product_number = 1
      cart_item.user_id = user_id
      cart_item.product = product
      cart_item.save
    end
    redirect_to request.referer, notice: '添加到购物车成功。'
  end

  def add_cart_num
    user_id = session[:current_userid]
    pid = params[:id]
    cart_item = CartItem.where(user_id:user_id, product_id:pid).first
    cart_item.product_number += 1
    cart_item.save
    redirect_to request.referer
  end

  def decrease_cart_num
    user_id = session[:current_userid]
    pid = params[:id]
    cart_item = CartItem.where(user_id:user_id, product_id:pid).first
    cart_item.product_number -= 1 if cart_item.product_number > 1
    cart_item.save
    redirect_to request.referer
  end

  def cart
    user_id = session[:current_userid]
    @cart_items = CartItem.where(user_id: user_id)
  end

  def product
    user_id = session[:current_userid]
    @product = Product.find(params[:id])
    @image = @product.image.nil?
    puts 'image', @image
    favorite = Favorite.where(user_id: user_id, product_id: @product.id).first
    if favorite
      @favorited = true
    else
      @favorited = false
    end

    follow = Follow.where(user_id: user_id, shop_id: @product.shop_id).first
    if follow
      @followed = true
    else
      @followed = false
    end
    @shop = @product.shop
  end

  def favorites
    user_id = session[:current_userid]
    @favorites = Favorite.where(user_id: user_id)
  end

  def favorite
    product = Product.find(params[:id])
    user_id = session[:current_userid]
    favorite = Favorite.new
    favorite.user_id = user_id
    favorite.product =product
    favorite.create_time = Time.now
    favorite.save
    redirect_to request.referer, notice: '收藏成功！'
  end

  def unfavorite
    product = Product.find(params[:id])
    user_id = session[:current_userid]
    favorite = Favorite.where(user_id: user_id, product_id: product.id).first
    favorite.delete
    redirect_to request.referer, notice: '取消收藏成功！'
  end

  def follow
    user_id = session[:current_userid]
    follow = Follow.new
    follow.user_id = user_id
    follow.shop_id = params[:id]
    follow.follow_time = Time.now
    follow.save
    redirect_to request.referer, notice: '关注成功！'
  end

  def unfollow
    user_id = session[:current_userid]
    follow = Follow.where(user_id: user_id, shop_id: params[:id]).first
    follow.delete
    redirect_to request.referer, notice: '取消关注成功！'
  end

  def checkout
    user_id = session[:current_userid]
    @addresses = Address.where(user_id: user_id)
    @pre_orders = {}
    cart_items = CartItem.where(user_id: user_id)
    for cart_item in cart_items
      shop_name = cart_item.product.shop.name
      if @pre_orders[shop_name]
        @pre_orders[shop_name].append(cart_item)
      else
        @pre_orders[shop_name] = [cart_item]
      end
    end
    sum = 0
    cart_items.map {|ci| sum += ci.product_number * ci.product.price}
    @total_price = sum
    @order_num = @pre_orders.size
  end

  def gen_order
    user_id = session[:current_userid]
    address = params[:address]
    puts address
    address = Address.where(user_id: user_id, address: address).first
    @pre_orders = {}
    cart_items = CartItem.where(user_id: user_id)
    cart_items.each { |cart_item|
      shop_id = cart_item.product.shop.id
      if @pre_orders[shop_id]
        @pre_orders[shop_id].append(cart_item)
      else
        @pre_orders[shop_id] = [cart_item]
      end
    }
    @pre_orders.each { |sid, cis|
      order = Order.new
      order.address = address
      order.user_id = user_id
      order.shop_id = sid
      order.order_id = Time.now.to_s + '-' + user_id.to_s + '-' + sid.to_s
      order.order_date = Time.now
      order.order_status = 0
      sum = 0
      cis.map {|ci| sum += ci.product_number * ci.product.price}
      order.order_price = sum
      order.save
      cis.each { |ci|
        order_item = OrderItem.new
        order_item.order = order
        order_item.product = ci.product
        order_item.product_name = ci.product_name
        order_item.product_number = ci.product_number
        order_item.save
        cp = ci.product
        cp.sales += order_item.product_number
        cp.save
      }
      message = Message.new
      message.message_type = 2
      message.create_date = Time.now
      message.user_id = order.user_id
      message.shop_id = order.shop_id
      message.content = '我下单了你家的商品。'
      message.save
    }
    cart_items.each {|ci| ci.delete}
    redirect_to place_order_success_path
  end

  def place_order_success
  end

  def my_orders
    order_status = params[:order_status].to_i
    user_id = session[:current_userid]
    if order_status == 5
      @orders = Order.where(user_id: user_id)
    elsif order_status == 0
      @orders = Order.where(user_id: user_id, order_status: 0)
    elsif order_status == 1
      @orders = Order.where(user_id: user_id, order_status: 1)
    elsif order_status == 2
      @orders = Order.where(user_id: user_id, order_status: 2)
    elsif order_status == 3
      @orders = Order.where(user_id: user_id, order_status: 3)
    end
    if @orders.blank?
      @no_order = true
    else
      @no_order = false
    end
  end

  def receive_product
    order_id = params[:order_id]
    order = Order.where(id: order_id).first
    order.order_status = 2
    order.save
    message = Message.new
    message.message_type = 2
    message.create_date = Time.now
    message.user_id = order.user_id
    message.shop_id = order.shop_id
    message.content = '用户已经收货。'
    message.save
    redirect_to request.referer, notice: '收货成功。'
  end

  def comment
    pid = params[:pid]
    user_id = session[:current_userid]
    comment = Comment.new
    comment.user_id = user_id
    comment.product_id = pid
    comment.content = params[:content]
    comment.create_date = Time.now
    comment.save
    redirect_to request.referer, notice: '评论成功。'
  end

  def finish_order
    order_id = params[:order_id]
    order = Order.where(id: order_id).first
    order.order_status = 3
    order.save
    message = Message.new
    message.message_type = 2
    message.create_date = Time.now
    message.user_id = order.user_id
    message.shop_id = order.shop_id
    message.content = '一笔订单已经完成。'
    message.save
    redirect_to request.referer, notice: '订单已完成。'
  end

  def my_messages
    user_id = session[:current_userid]
    @messages = Message.where(user_id: user_id, message_type: 1)
  end

  def my_message_delete
    message = Message.find(params[:id])
    message.delete
    redirect_to request.referer, notice: '删除消息成功。'
  end

  def shop_info
    @shop = Shop.find(params[:id])
    @image = @shop.image.nil?
  end

  def authenticate
    redirect_to login_path, alert: '请先登录!' unless session[:current_userid]
  end

  def database_clear
    for address in Address.all
      address.delete
    end
    for address in User.all
      address.delete
    end
    for address in Shop.all
      address.delete
    end
    for address in CartItem.all
      address.delete
    end
    for address in Comment.all
      address.delete
    end
    for address in Favorite.all
      address.delete
    end
    for address in Follow.all
      address.delete
    end
    for address in Message.all
      address.delete
    end
    for address in Order.all
      address.delete
    end
    for address in OrderItem.all
      address.delete
    end
    for address in Product.all
      address.delete
    end
    for address in ProductType.all
      address.delete
    end
    for address in Seller.all
      address.delete
    end
    redirect_to root_path
  end
end
