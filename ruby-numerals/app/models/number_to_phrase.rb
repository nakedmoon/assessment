class NumberToPhrase
  include ActiveModel::Model

  attr_accessor :number
  attr_reader :word


  SMALL = ["zero",  "one",   "two",  "three", "four",   "five",   "six",
                 "seven", "eight", "nine", "ten",   "eleven", "twelve", "thirteen",
                 "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
  ]
  TENS  = ["twenty",
           "thirty",
           "forty",
           "fifty",
           "sixty",
           "seventy",
           "eighty",
           "ninety"
  ]
  SCALE = ["", "thousand", "million", "billion", "trillion",  "quadrillion",
           "quintillion",  "sextillion",      "septillion",    "octillion",
           "nonillion", "decillion",    "undecillion",     "duodecillion",
           "tredecillion",   "quattuordecillion", "sexdecillion", "septendecillion",
           "octodecillion", "novemdecillion", "vigintillion"
  ]

  validates :number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true, allow_blank: false

  def save
    begin
      return false if invalid?
      @word = english_number(@number.to_i)
      return true
    rescue Exception => e
      self.errors.add(:number, e.message)
      return false
    end
  end


  private

  def convert_nn(value)
    return SMALL[value] if value < 20
    for v in (0...TENS.length) do
      dcap = TENS[v]
      dval = 20 + 10*v
      if (dval + 10) > value
        return [dcap, '-', SMALL[value % 10]].join('') if ((value%10) != 0)
        return dcap;
      end
    end
  end

  def convert_nnn(value)
    word = ""
    rem = value / 100
    mod = value % 100
    if rem > 0
      word = [SMALL[rem], "hundred"].join(' ')
      word += ' ' if mod > 0
    end
    if mod > 0
      word += 'and ' if word.present?
      word += convert_nn(mod)
    end
    return word
  end

  def english_number(value)
    return convert_nn(value) if value < 100
    return convert_nnn(value) if value < 1000
    for v in (0...SCALE.length) do
      d_index = v -1
      d_value = (1000 ** v).to_i
      if d_value > value
        mod = (1000 ** d_index).to_i
        l = value / mod
        r = value - (l * mod)
        ret = [convert_nnn(l), SCALE[d_index]].join(' ')
        if r > 0
          sep = r.between?(1,100) ? ' and ' : ', '
          ret = [ret, english_number(r)].join(sep)
        end

        return ret
      end
    end
  end









end
