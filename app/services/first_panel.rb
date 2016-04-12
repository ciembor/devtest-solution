require 'open-uri'

class FirstPanel
  def price
    with_currency(text(doc).count('a').fdiv(100))
  end

  private

  def with_currency(price)
    "#{'%.2f' % price} PLN"
  end

  def doc
    Nokogiri::HTML(open('http://time.com'))
  end

  def text(doc)
    string = ''
    doc.traverse { |node| string << node.text if node.text? }
    string
  end
end
