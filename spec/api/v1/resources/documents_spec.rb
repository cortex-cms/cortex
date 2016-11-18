describe SPEC_API::Resources::Documents, type: :request do

  let(:user) { create(:user, :admin) }

  describe 'GET /documents' do

    it 'returns an empty array if there are no documents' do
      get '/api/v1/documents'
      expect(response).to be_success
      expect(JSON.parse(response.body)).to eq([])
    end

    it 'should return two documents' do
      2.times { create(:document, user: user) }
      get '/api/v1/documents'
      expect(response).to be_success
      expect(JSON.parse(response.body).count).to eq(2)
    end

    it 'should return paginated results' do
      5.times { create(:document, user: user) }
      get '/api/v1/documents?per_page=2'
      expect(response).to be_success
      expect(JSON.parse(response.body).count).to eq(2)
      expect(response.headers['X-Total']).to eq('5')
    end
  end

  describe 'GET /documents/:id' do

    let(:document) { create(:document, user: user) }

    it 'should return the correct document' do
      get "/api/v1/documents/#{document.id}"
      expect(response).to be_success
      expect(response.body).to represent(SPEC_API::Entities::Document, document)
    end
  end

  describe 'POST /documents' do

    context 'with valid attributes' do
      it 'should create new document' do
        pending 'Broken!'
        expect{ post '/api/v1/documents', document: attributes_for(:document) }.to change(Document, :count).by(1)
        expect(response).to be_success
        expect(response.body).to represent(SPEC_API::Entities::Document, Document.last)
      end
    end
  end

  describe 'PUT /documents/:id' do

    context 'with valid attributes' do
      it 'should update document' do
        document = create(:document, user: user)
        document.name += ' updated'
        expect{ put "/api/v1/documents/#{document.id}", document.to_json, application_json }.to_not change(Document, :count)
        expect(response).to be_success
        expect(response.body).to represent(SPEC_API::Entities::Document, document)
      end
    end
  end

  describe 'DELETE /documents/:id' do

    it 'should delete document' do
      document = create(:document, user: user)
      expect{ delete "/api/v1/documents/#{document.id}" }.to change(Document, :count).by(-1)
      expect(response).to be_success
    end

    it 'should NOT delete non-existent document' do
      document = create(:document, user: user)
      expect{ delete "/api/v1/documents/#{document.id+1}" }.to_not change(Document, :count)
      expect(response).not_to be_success
    end

    it 'should not delete consumed document' do
      pending 'Switch to Snippet relation rather than direct to Document'
      document = create(:document, user: user)
      snippet = create(:snippet)
      webpage = create(:webpage, user: user)
      webpage.documents << snippet
      webpage.save
      expect { delete "/api/v1/documents/#{document.id}" }.to_not change(Document, :count)
      expect(Document.exists? document.id).to be_truthy
      expect(response.status).to eq(409)
    end
  end
end
