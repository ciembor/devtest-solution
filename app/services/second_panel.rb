require 'open-uri'

class SecondPanel
  def price
    with_currency(text.scan('\u003cb\u003e').length)
  end

  private

  def with_currency(price)
    "#{'%.2f' % price} GBP"
  end

  def text
    open('https://ajax.googleapis.com/ajax/services/feed/find?v=1.0&q=news').read
  end
end
