class ContentTypesController < AdminController
  add_breadcrumb 'Content Types', :content_types_path

  def index
    @content_types = ContentType.all
  end

  def new
  end

  def new_type
    @content_type = ContentType.new content_type_params
    if @content_type.save!
      respond_to do |format|
        format.json { render :json => @content_type }
      end
    else
      respond_to do |format|
        format.json { render :json => @content_type.errors }
      end
    end
  end

  def update_type
    @content_type = ContentType.find(params[:id])
    if @content_type.update(content_type_params)
      respond_to do |format|
        format.json { render :json => @content_type }
      end
    else
      respond_to do |format|
        format.json { render :json => @content_type.errors }
      end
    end
  end

  def create_fields
    @content_type = ContentType.find(params[:content_type_id])
    params[:fields].each do |field|
      @content_type.fields.new({
        name: field[:name],
        field_type: field[:field_type],
        validations: field[:validations] || {},
        metadata: field[:metadata] || {}
        })
    end
    if @content_type.save!
      respond_to do |format|
        format.json { render :json => @content_type.fields }
      end
    else
      respond_to do |format|
        format.json { render :json => @content_type.errors }
      end
    end
  end

  def edit

  end

  def create

  end

  def content_type_params
    params.permit(:name, :description, :creator_id, :tenant_id, :icon, :contract_id, :field_type, :fields, :metadata ,:validations)
  end
end
