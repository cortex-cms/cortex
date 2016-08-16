class WizardCell < Cell::ViewModel
  property :data

  def show
    render
  end

  private

  def data_mash
    Hashie::Mash.new(data)
  end
end
