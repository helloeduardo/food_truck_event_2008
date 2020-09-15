class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    food_trucks.find_all do |truck|
      truck.inventory.include?(item)
    end
  end

  def all_items_sold
    food_trucks.map do |truck|
      truck.inventory.map do |item, amount|
        item
      end
    end.flatten.uniq
  end

  def total_inventory
    total_inventory = {}
    all_items_sold.each do |item|
      item_inventory = Hash.new(0)
      food_trucks.each do |truck|
        item_inventory[:quantity] += truck.check_stock(item)
      end
      item_inventory[:food_trucks] = food_trucks_that_sell(item)
      total_inventory[item] = item_inventory
    end
    total_inventory
  end

  def overstocked_items
    overstocked_items = []
    total_inventory.each do |item, item_inventory|
      if item_inventory[:quantity] > 50 && item_inventory[:food_trucks].count > 1
        overstocked_items << item
      end
    end
    overstocked_items
  end

end
