require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:valid_pdf) { fixture_file_upload('cv_jorge_gonzalez.pdf', 'application/pdf') }
  let(:invalid_file) { fixture_file_upload('cv_jorge_gonzalez.png', 'image/png') }

  describe "validations" do
    it "is valid with a pdf attached file" do
      document = build(:document, file: valid_pdf)
      expect(document).to be_valid
    end

    it "is invalid without a file" do
      document = build(:document)
      expect(document).not_to be_valid
      expect(document.errors[:file]).to include('must be present')
    end

    it "is invalid with non-pdf file" do
      document = build(:document, file: invalid_file)
      expect(document).not_to be_valid
      expect(document.errors[:file]).to include('must be a pdf')
    end
  end

  describe "#index_file" do
    it "updates indexed to true when VECTOR_SEARCH_CLIENT.add_texts returns true" do
      document = build(:document, file: valid_pdf)
      allow(document).to receive(:chunks).and_return(%w[chunk1 chunk2])
      allow(VECTOR_SEARCH_CLIENT).to receive(:add_texts).and_return(true)
      document.index_file
      expect(document.indexed).to be(true)
    end
  end
end