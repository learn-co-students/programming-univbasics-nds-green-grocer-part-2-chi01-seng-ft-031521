require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  counter = 0
  while counter < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    coupouned_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupouned_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => coupouned_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1
  end
  cart
end

def apply_clearance(cart)
  cart.each do |cart_item|
    if cart_item[:clearance]
      cart_item[:price] = (cart_item[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  total = 0
  
  final_cart.each do |cart_item|
    item_total_price = cart_item[:price] * cart_item[:count]
    total += item_total_price
  end
  if total > 100
    total -= (total * 0.1)
  end
  total
end
