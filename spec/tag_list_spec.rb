require 'tag_list'

# From Avdi Grimm's "Adding tags" chapter in his book
# "Objects on Rails" http://objectsonrails.com/
# (Rewritten in Rspec's expectations DSL)
describe TagList do
  context "given a blank string" do
    subject { TagList.new "" }

    it "is empty" do
      expect(subject).to be_empty
    end

    it "stringifies to the empty string" do
      expect(subject.to_s).to eq("")
    end

    it "arrayifies to the empty array" do
      expect(subject.to_a).to eq([])
    end
  end

  context "given nil" do
    subject { TagList.new nil }

    it "is empty" do
      expect(subject).to be_empty
    end
  end

  context "given tags separated by commas or whitespace" do
    subject { TagList.new "ruby, writing, cat dogs" }

    it "is not empty" do
      expect(subject).to_not be_empty
    end

    it "stringifies to a comma separated list" do
      expect(subject.to_s).to eq("ruby, writing, cat, dogs")
    end

    it "arrayifies to a list of strings" do
      expect(subject.to_a).to eq(%w(ruby writing cat dogs))
    end
  end

  context "given duplicate tags" do
    subject { TagList.new "programming, clojure, programming" }

    it "eliminates duplicates" do
      expect(subject.to_a).to eq(%w(programming clojure))
    end
  end

  context "given duplicate mixed case tags" do
    subject { TagList.new "Programming, cloJure, proGramming" }

    it "eliminates duplicates ignoring case" do
      expect(subject.to_a).to eq(%w(programming clojure))
    end
  end

  describe "#+" do
    it "combines tag lists into one" do
      actual   = TagList.new("foo, bar") + TagList.new("baz, buz")
      expected = TagList.new "foo, bar, baz, buz"
      expect(actual).to eq(expected)
    end
  end

  describe "#alphabetical" do
    subject { TagList.new("books, art, cooking").alphabetical }

    it "returns the tags in alphabetical order" do
      expect(subject).to eq(%w(art books cooking))
    end
  end

  describe "TagList()" do
    before { extend Conversions }

    context "given a TagList" do
      it "returns the same tag list" do
        list = TagList.new ""
        expect(TagList(list)).to eq(list)
      end
    end

    context "given an Array" do
      subject { TagList(%w(cats dogs rabbits)) }

      it "returns a tag list" do
        expect(subject).to be_kind_of(TagList)
      end

      it "contains the given tags" do
        expect(subject.to_a).to eq(%w(cats dogs rabbits))
      end
    end
  end
end
