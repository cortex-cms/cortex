describe SPEC_API::Resources::ContentTypes, type: :request do
  let(:user) { create(:user, :admin) }

  before(:each) do
    login_as user
  end

  describe 'GET /content_types' do
    before(:each) do
      3.times { |i| create(:content_type, name: "Bloggy #{i}") }
    end

    it "returns all content types" do
      get '/api/v1/content_types'
      expect(response).to be_success
      expect(JSON.parse(response.body).map { |content_type| content_type['name'] }).to match_array(["Bloggy 0", "Bloggy 1", "Bloggy 2"])
    end
  end

  describe 'GET /content_types/:content_type_id' do
    let(:content_type) { create(:content_type, name: "Blog post") }
    let!(:last_name_field) { create(:field, content_type: content_type, name: "Last Name", validations: { length: 20}) }
    let!(:first_name_field) { build(:field, name: "First Name") }
    let(:content_type_response) do
      {
        id: content_type.id,
        name: content_type.name,
        fields: [
          {
            required: first_name_field.required,
            field_type: first_name_field.field_type,
            name: first_name_field.name,
            validations: first_name_field.validations
          },
          {
            required: last_name_field.required,
            field_type: last_name_field.field_type,
            name: last_name_field.name,
            validations: last_name_field.validations
          }
        ]
      }
    end

    before do
      first_name_field.update(content_type: content_type)
    end

    xit "returns the fields for the specified content type" do
      get "/api/v1/content_types/#{content_type.id}"
      expect(JSON.parse(response.body, symbolize_names: true)).to eq content_type_response
    end
  end
end
