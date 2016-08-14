class WizardCell < Cell::ViewModel
  property :data

  def show
    cell('wizard/step', collection: data_mash.steps).()
  end

  def data_mash
    Hashie::Mash.new(data)
  end
end
