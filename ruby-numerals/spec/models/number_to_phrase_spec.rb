require 'spec_helper'

describe NumberToPhrase do

  it "is invalid without number" do
    expect(Fabricate(:number_to_phrase, :number => nil)).to be_invalid
  end

  it "is invalid with a negative number" do
    expect(Fabricate(:number_to_phrase, :number => -1)).to be_invalid
  end

  it "is invalid with a blank number" do
    expect(Fabricate(:number_to_phrase, :number => '')).to be_invalid
  end

  it "is invalid with a string" do
    expect(Fabricate(:number_to_phrase, :number => 'string')).to be_invalid
  end

  it "is valid if number is a string representing a number" do # to_i conversion
    expect(Fabricate(:number_to_phrase, :number => '10')).to be_valid
  end

  it "save return true if valid object" do
    number_to_phrase = Fabricate(:number_to_phrase, :number => 100)
    expect(number_to_phrase).to be_valid
    expect(number_to_phrase.save).to be_true
  end

  it "set word to zero with 0 as number" do
    number_to_phrase = Fabricate(:number_to_phrase, :number => '0')
    expect(number_to_phrase.save).to be_true
    expect(number_to_phrase.word).to eq('zero')
  end

  it "set word to ninety-nine with 99 as number" do
    number_to_phrase = Fabricate(:number_to_phrase, :number => '99')
    expect(number_to_phrase.save).to be_true
    expect(number_to_phrase.word).to eq('ninety-nine')
  end

  it "set word to one hundred with 100 as number" do
    number_to_phrase = Fabricate(:number_to_phrase, :number => '100')
    expect(number_to_phrase.save).to be_true
    expect(number_to_phrase.word).to eq('one hundred')
  end

  it "set word to one hundred and one with 101 as number" do
    number_to_phrase = Fabricate(:number_to_phrase, :number => '101')
    expect(number_to_phrase.save).to be_true
    expect(number_to_phrase.word).to eq('one hundred and one')
  end

  it "set word to three thousand and one with 3000 as number" do
    number_to_phrase = Fabricate(:number_to_phrase, :number => '3000')
    expect(number_to_phrase.save).to be_true
    expect(number_to_phrase.word).to eq('three thousand')
  end

  it "set word to three thousand and ten and one with 3010 as number" do
    number_to_phrase = Fabricate(:number_to_phrase, :number => '3010')
    expect(number_to_phrase.save).to be_true
    expect(number_to_phrase.word).to eq('three thousand and ten')
  end

  it "set word to three thousand, one hundred and ten and one with 3110 as number" do
    number_to_phrase = Fabricate(:number_to_phrase, :number => '3110')
    expect(number_to_phrase.save).to be_true
    expect(number_to_phrase.word).to eq('three thousand, one hundred and ten')
  end


end






