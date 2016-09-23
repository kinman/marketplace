json.array! @customers do |c|
  json.(c, :id, :name)
  json.orders(c.orders.count)
end