require 'spec_helper'

RSpec.describe CrushinatorHelpers::ViewHelpers, type: :helper do

  describe "crushinate" do

    let(:url) { "http://img.tedcdn.com"}
    let(:secure_url) { "https://img-ssl.tedcdn.com"}
    let(:path) { "/images/playlists/are_we_alone_in_the_universe.jpg"}

    describe "https requests" do

      before(:each) do
        allow(controller.request).to receive(:ssl?).and_return(true)
      end

      %w(assets.tedcdn.com images.ted.com storage.ted.com tedlive.ted.com tedlive-staging.ted.com).each do |proxied|
        it "should add ssl prefix and suffix for #{proxied}" do
          expect(helper.crushinate \
            "http://#{proxied}#{path}"
          ).to eq(
            "#{secure_url}/r/#{proxied}#{path}?"
          )
        end

        it "should never attempt to pass an image through crushinate twice" do
          expect(helper.crushinate \
            "#{secure_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500"
          ).to eq(
            "#{secure_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500"
          )
        end

        it "should prefer new options when attempting to crushinate an image twice" do
          expect(helper.crushinate \
            "#{secure_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500",
            {quality: 90, w: 320}
          ).to eq(
            "#{secure_url}/r/#{proxied}#{path}?ll=1&quality=90&w=320"
          )
        end
      end

    end

    describe "http requests" do

      %w(assets.tedcdn.com images.ted.com storage.ted.com tedlive.ted.com tedlive-staging.ted.com).each do |proxied|
        it "should should not add ssl prefix and suffix for #{proxied}" do
          expect(helper.crushinate \
            "http://#{proxied}#{path}"
          ).to eq(
            "#{url}/r/#{proxied}#{path}?"
          )
        end

        it "should never attempt to pass an image through crushinate twice" do
          expect(helper.crushinate \
            "#{url}/r/#{proxied}#{path}?ll=1&quality=89&w=500"
          ).to eq(
            "#{url}/r/#{proxied}#{path}?ll=1&quality=89&w=500"
          )
        end

        it "should prefer new options when attempting to crushinate an image twice" do
          expect(helper.crushinate \
            "#{url}/r/#{proxied}#{path}?ll=1&quality=89&w=500",
            {quality: 90, w: 320}
          ).to eq(
            "#{url}/r/#{proxied}#{path}?ll=1&quality=90&w=320"
          )
        end
      end

    end

    it "should append options as a query string" do
      expect(helper.crushinate \
        "http://images.ted.com#{path}", { money: 'nothing', chicks: 'free' }
      ).to eq(
        "#{url}/r/images.ted.com#{path}?chicks=free&money=nothing"
      )
    end

  end

end
