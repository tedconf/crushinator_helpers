require 'spec_helper'

RSpec.describe CrushinatorHelpers::ViewHelpers, type: :helper do

  describe "crushinate" do

    let(:l3_url) { "http://img.tedcdn.com"}
    let(:edgecast_url) { "https://tedcdnpi-a.akamaihd.net"}
    let(:edgecast_url) { "https://pi.tedcdn.com"}

    let(:path) { "/images/playlists/are_we_alone_in_the_universe.jpg"}
    let(:image_path) { "tedcdnpe-a.akamaihd.net/images/ted/d3b8fd408c1f2576d86a6d781da0dfd768d0cda4_240x180.jpg"}
    let(:asset_path) { "tedcdnpf-a.akamaihd.net/images/playlists/talks_for_foodies_268x268.jpg"}


    describe "https requests" do

      before(:each) do
        allow(controller.request).to receive(:ssl?).and_return(true)
      end

      %w(assets.tedcdn.com images.ted.com s3.amazonaws.com storage.ted.com tedlive.ted.com tedlive-staging.ted.com).each do |proxied|
        it "should add ssl prefix and suffix for #{proxied}" do
          expect(helper.crushinate \
            "http://#{proxied}#{path}"
          ).to eq(
            "#{edgecast_url}/r/#{proxied}#{path}?"
          )
        end

        it "should never attempt to pass an image through crushinate twice" do
          expect(helper.crushinate \
            "#{edgecast_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500"
          ).to eq(
            "#{edgecast_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500"
          )
        end

        it "should fix old level3 urls and make them akamai urls" do
          expect(helper.crushinate \
            "#{l3_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500"
          ).to eq(
            "#{edgecast_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500"
          )
        end

        it "should prefer new options when attempting to crushinate an image twice" do
          expect(helper.crushinate \
            "#{edgecast_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500",
            {quality: 90, w: 320}
          ).to eq(
            "#{edgecast_url}/r/#{proxied}#{path}?ll=1&quality=90&w=320"
          )
        end
      end

    end

    describe "http requests" do

      %w(assets.tedcdn.com images.ted.com storage.ted.com tedlive.ted.com tedlive-staging.ted.com).each do |proxied|
        it "should add ssl prefix and suffix for #{proxied}" do
          expect(helper.crushinate \
            "http://#{proxied}#{path}"
          ).to eq(
            "#{edgecast_url}/r/#{proxied}#{path}?"
          )
        end

        it "should never attempt to pass an image through crushinate twice" do
          expect(helper.crushinate \
            "#{edgecast_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500"
          ).to eq(
            "#{edgecast_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500"
          )
        end

        it "should prefer new options when attempting to crushinate an image twice" do
          expect(helper.crushinate \
            "#{edgecast_url}/r/#{proxied}#{path}?ll=1&quality=89&w=500",
            {quality: 90, w: 320}
          ).to eq(
            "#{edgecast_url}/r/#{proxied}#{path}?ll=1&quality=90&w=320"
          )
        end
      end

    end

    it "should append options as a query string" do
      expect(helper.crushinate \
        "http://images.ted.com#{path}", { foo: 1, bar: 2 }
      ).to eq(
        "#{edgecast_url}/r/images.ted.com#{path}?bar=2&foo=1"
      )
    end

    it "should properly crushinate images on akamai image url" do
      expect(helper.crushinate \
        "http://#{image_path}", { foo: 1, bar: 2 }
      ).to eq(
        "#{edgecast_url}/r/#{image_path}?bar=2&foo=1"
      )
    end

    it "should properly crushinate images on akamai asset url" do
      expect(helper.crushinate \
        "http://#{asset_path}", { foo: 1, bar: 2 }
      ).to eq(
        "#{edgecast_url}/r/#{asset_path}?bar=2&foo=1"
      )
    end

    it "should smooth over double slashes in a URL" do
      expect(helper.crushinate \
        "https://s3.amazonaws.com/ted.conferences.profiles//00/00/03/8d/36/232758.jpg"
      ).to eq (
        "https://pi.tedcdn.com/r/s3.amazonaws.com/ted.conferences.profiles/00/00/03/8d/36/232758.jpg?"
      )
    end

  end

end
