require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(consolidated_cart, coupons)
  consolidated_cart.each do |consolidated_item|
    item_with_coupon = find_item_by_name_in_collection(consolidated_item[:item], coupons)
    if item_with_coupon != nil
      #create item with coupon applied
      item_coupon_applied = {}
      #update item name for coupon hash
      item_coupon_applied[:item] = item_with_coupon[:item] + " W/COUPON"
      #update count of original item and remove item if count is 0
      #do nothing if there are fewer items than coupon is applicable for
      if consolidated_item[:count] >= item_with_coupon[:num]
        consolidated_item[:count] -= item_with_coupon[:num]
        #update price per item from coupon 
        item_coupon_applied[:price] = item_with_coupon[:cost]/item_with_coupon[:num]
        #add rest of entries into hash 
        item_coupon_applied[:clearance] = consolidated_item[:clearance] 
        item_coupon_applied[:count] = item_with_coupon[:num]
        consolidated_cart << item_coupon_applied
      end
    end 
  end 
consolidated_cart
end

def apply_clearance(cart)
  cart.each do |consolidated_item|
    if consolidated_item[:clearance]
      consolidated_item[:price] = (consolidated_item[:price] * 0.8).round(2)
    end 
  end 
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart_w_coupons = apply_coupons(consolidated_cart, coupons)
  updated_prices_cart = apply_clearance(consolidated_cart_w_coupons)
  total_cost = 0
  updated_prices_cart.each do |item_with_updated_price|
    cost_of_item = item_with_updated_price[:count] * item_with_updated_price[:price]
    total_cost += cost_of_item  
  end 
  if total_cost > 100
    total_cost *= 0.90
  end   
  total_cost
end