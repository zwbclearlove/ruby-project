class ShopViewsController < ApplicationController
  before_action :authenticate, except: [:login, :register, :do_login, :do_register]

  def login
  end

  def do_login
    print(params)
    seller = Seller.where(username: params[:username], password: params[:password]).first
    if seller
      session[:current_sellerid] = seller.id
      shop = Shop.where(seller_id: seller.id).first
      if shop
        session[:current_shopid] = shop.id
        redirect_to shop_info_path, notice: '卖家登录成功。'
      else
        redirect_to shop_shop_register_path, notice: '需要完善信息。'
      end
    else
      redirect_to shop_login_path, alert: '用户名或密码错误。'
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
    seller = Seller.where(username:username).first
    print(seller)
    if seller
      redirect_to shop_register_url, alert: '用户名已存在。' and return
    end
    unless password_confirm == password
      redirect_to shop_register_url, alert: '密码不匹配。' and return
    end
    seller = Seller.new
    seller.username = username
    seller.email = email
    seller.password = password
    seller.save
    redirect_to shop_login_path, notice: '卖家注册成功，请登录。'
  end

  def logout
    session.delete(:current_sellerid)
    session.delete(:current_shopid)
    redirect_to shop_login_path, alert: '卖家退出成功。'
  end

  def shop_register
  end

  def do_shop_register
    name = params[:name]
    address = params[:address]
    description = params[:description]
    phone = params[:phone]
    print(name)
    print(address)
    print description
    print phone
    shop = Shop.new
    shop.name = name
    shop.address = address
    shop.description = description
    shop.telephone = phone
    shop.seller_id = session[:current_sellerid]
    shop.save
    session[:current_shopid] = shop.id
    redirect_to shop_info_path, notice: '商店信息已经完善。'
  end

  def shop_info
    seller_id = session[:current_sellerid]
    @seller = Seller.where(id:seller_id).first
    @shop = Shop.where(seller_id: seller_id).first
    @image = @shop.image.nil?
  end

  def shop_image_update
    shop_id = session[:current_shopid]
    @shop = Shop.where(id:shop_id).first
    render 'image_update'
  end

  def do_shop_image_update
    shop_id = session[:current_shopid]
    @shop = Shop.where(id:shop_id).first
    uploaded_file = params[:picture]
    File.open(Rails.root.join('app', 'assets', 'images', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end
    puts uploaded_file
    @shop.image = uploaded_file.original_filename
    @shop.save
    redirect_to shop_info_path, notice: '商店图表修改成功。'
  end

  def add_product
    name = params[:name]
    price = params[:price]
    description = params[:description]
    stock = params[:stock]
    type = params[:type]
    print name, price, description, stock, type
    ptype = ProductType.where(name: type).first

    product = Product.new
    product.name = name
    product.price = price
    product.stock = stock
    product.sales = 0
    product.image = 'no_image.png'
    product.description = description
    product.product_type = ptype
    product.shop_id = session[:current_shopid]
    product.save
    redirect_to shop_product_list_path, notice: '添加商品成功。'
  end

  def product_list
    shop_id = session[:current_shopid]
    @types = ProductType.all
    @products = Product.where(shop_id: shop_id)
  end

  def product
    @product = Product.find(params[:id])
    @image = @product.image.nil?
  end

  def product_image_update
    @product = Product.find(params[:id])
    render 'upload_image.html.erb'
  end

  def do_product_image_update
    @product = Product.find(params[:id])
    uploaded_file = params[:picture]
    File.open(Rails.root.join('app', 'assets', 'images', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end
    puts uploaded_file
    @product.image = uploaded_file.original_filename
    @product.save
    redirect_to show_product_path(@product), notice: '商品图片修改成功。'
  end

  def my_orders
    shop_id = session[:current_shopid]
    order_status = params[:order_status].to_i
    case order_status
    when 5
      @orders = Order.where(shop_id: shop_id)
    when 0
      @orders = Order.where(shop_id: shop_id, order_status: 0)
    when 1
      @orders = Order.where(shop_id: shop_id, order_status: 1)
    when 2
      @orders = Order.where(shop_id: shop_id, order_status: 2)
    when 3
      @orders = Order.where(shop_id: shop_id, order_status: 3)
    else
      @orders = nil
    end
    if @orders.blank?
      @no_order = true
    else
      @no_order = false
    end
  end

  def my_messages
    shop_id = session[:current_shopid]
    @messages = Message.where(shop_id: shop_id, message_type: 2)
  end

  def ship_product
    order_id = params[:order_id]
    order = Order.where(id: order_id).first
    order.order_status = 1
    order.save
    message = Message.new
    message.message_type = 1
    message.create_date = Time.now
    message.user_id = order.user_id
    message.shop_id = order.shop_id
    message.content = ''
    message.save
    redirect_to request.referer, notice: '发货成功。'
  end

  def urge_comment
    order_id = params[:order_id]
    order = Order.where(id: order_id).first
    message = Message.new
    message.message_type = 1
    message.create_date = Time.now
    message.user_id = order.user_id
    message.shop_id = order.shop_id
    message.content = '你有一件商品需要评价。'
    message.save
    redirect_to request.referer, notice: '催促评价成功。'
  end

  def product_types
    @product_types = ProductType.all
  end

  def authenticate
    redirect_to shop_login_path, alert: 'Must login!' unless session[:current_sellerid]
  end

end
