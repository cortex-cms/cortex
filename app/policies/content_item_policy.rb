class ContentItemPolicy
  attr_reader :user, :content_item

  def initialize(user, content_item)
    @user = user
    @content_item = content_item
    @content_type = @content_item.content_type
  end

  def index?
    has_permission?("Index")
  end

  def show?
    has_permission?("Show")
  end

  def create?
    has_permission?("Create")
  end

  def new?
    has_permission?("New")
  end

  def update?
    has_permission?("Update")
  end

  def edit?
    has_permission?("Edit")
  end

  def destroy?
    has_permission?("Destroy")
  end

  def can_publish?
    has_permission?("Publish")
  end

  private

  def has_permission?(permission)
    @user.has_permission?(@content_type, permission)
  end
end
