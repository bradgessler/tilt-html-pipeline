require 'spec_helper'

describe Tilt::HTML::Pipeline do
  subject { Tilt.new(path, :default_encoding => 'UTF-8') }

  let(:path) { Tilt::HTML::Pipeline.root.join('./../../../spec/fixtures/test.braddown') }
  let(:extension) { File.extension(path) }
  let(:pipeline) { ::HTML::Pipeline.new [ HTML::Pipeline::MentionFilter ] }

  before do
    Tilt.register_html_pipeline 'braddown', [
      ::HTML::Pipeline::MentionFilter
    ], { asset_path: './images' }
  end

  it "renders HTML pipeline" do
    expect(subject.render).to include('<a href="/brad" class="user-mention">@brad</a>')
  end
end