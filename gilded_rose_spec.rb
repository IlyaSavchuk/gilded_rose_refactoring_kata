require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    let(:items) { [] }

    context 'when item name is Sulfuras, Hand of Ragnaros' do
      before do
        items << Item.new('Sulfuras, Hand of Ragnaros', 2, 2)
      end

      it 'does not change the quality and sell_in' do
        GildedRose.new(items).update_quality()
        expect(items.first).to have_attributes(
          sell_in: 2,
          quality: 2
        )
      end
    end

    context 'when item name is Aged Brie' do
      before do
        items << Item.new('Aged Brie', 2, 2)
      end

      it 'changed the quality and sell_in' do
        GildedRose.new(items).update_quality()
        expect(items.first).to have_attributes(
          sell_in: 1,
          quality: 3
        )
      end
    end

    context 'when usual item' do
      before do
        items << Item.new('Usual item', 2, 2)
      end

      it 'changed the quality and sell_in' do
        GildedRose.new(items).update_quality()
        expect(items.first).to have_attributes(
          sell_in: 1,
          quality: 1
        )
      end
    end

    context 'when quality degrades twice as fast' do
      before do
        items << Item.new('Usual item', 0, 2)
      end

      it 'changed the quality and sell_in' do
        GildedRose.new(items).update_quality()
        expect(items.first).to have_attributes(
          sell_in: -1,
          quality: 0
        )
      end
    end

    context 'when quality of an item is never negative' do
      before do
        items << Item.new('Usual item', 0, 0)
      end

      it 'changed the quality and sell_in' do
        GildedRose.new(items).update_quality()
        expect(items.first).to have_attributes(
          sell_in: -1,
          quality: 0
        )
      end
    end

    context 'when item name is Backstage passes to a TAFKAL80ETC concert' do
      context 'when sell_in is more 10 days' do
        before do
          items << Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 2)
        end

        it 'changed the quality and sell_in' do
          GildedRose.new(items).update_quality()
          expect(items.first).to have_attributes(
            sell_in: 14,
            quality: 3
          )
        end
      end

      context 'when sell_in is less or equal 10 days' do
        before do
          items << Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 2)
        end

        it 'changed the quality and sell_in' do
          GildedRose.new(items).update_quality()
          expect(items.first).to have_attributes(
            sell_in: 9,
            quality: 4
          )
        end
      end

      context 'when sell_in is less or equal 5 days' do
        before do
          items << Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 2)
        end

        it 'changed the quality and sell_in' do
          GildedRose.new(items).update_quality()
          expect(items.first).to have_attributes(
            sell_in: 4,
            quality: 5
          )
        end
      end

      context 'when sell_in is 0 days' do
        before do
          items << Item.new('Backstage passes to a TAFKAL80ETC concert', 1, 2)
        end

        it 'changed the quality and sell_in' do
          GildedRose.new(items).update_quality()
          expect(items.first).to have_attributes(
            sell_in: 0,
            quality: 0
          )
        end
      end
    end
  end
end
