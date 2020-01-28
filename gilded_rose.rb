class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name == 'Sulfuras, Hand of Ragnaros'

      decrease_sell_in(item)
      update_item_quality(item)
    end
  end

  def update_item_quality(item)
    case item.name
    when 'Backstage passes to a TAFKAL80ETC concert'
      Backstage.new(item).update
    when 'Aged Brie'
      AgedBrie.new(item).update
    when 'Conjured'
      Conjured.new(item).update
    else
      UsualItem.new(item).update
    end
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end
end

class UsualItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update
    decrease_quality(1) if item.quality < 50 && item.quality > 0
  end

  def decrease_quality(size)
    return item.quality -= size * 2 if item.sell_in <= 0

    item.quality -= size
  end

  def increase_quality
    item.quality += 1
  end
end

class AgedBrie < UsualItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update
    increase_quality if item.quality < 50
    increase_quality if expired?
  end

  def expired?
    item.sell_in <= 0
  end
end

class Backstage < UsualItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update
    increase_quality if item.quality < 50
    increase_quality if item.sell_in <= 10
    increase_quality if item.sell_in <= 5
    item.quality = 0 if item.sell_in <= 0
  end
end

class Conjured < UsualItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update
    decrease_quality(2)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
