require 'open-uri'

class ThirdPanel
  def price
    with_currency(doc.css('*').count.fdiv(100))
  end

  private

  def with_currency(price)
    "#{'%.2f' % price} Euro"
  end

  def doc
    Nokogiri::HTML(open('http://time.com'))
  end
end
