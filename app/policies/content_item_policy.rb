class ContentItemPolicy
  attr_reader :user, :content_item

  def initialize(user, content_item)
    @user = user
    @content_item = content_item
    @content_type = @content_item.content_type
  end

  def index?
    user_is_admin? || @user.has_permission?(@content_type, "Index")
  end

  def show?
    user_is_admin? || @user.has_permission?(@content_type, "Show")
  end

  def create?
    user_is_admin? || @user.has_permission?(@content_type, "Create")
  end

  def new?
    user_is_admin? || @user.has_permission?(@content_type, "New")
  end

  def update?
    user_is_admin? || @user.has_permission?(@content_type, "Update")
  end

  def edit?
    user_is_admin? || @user.has_permission?(@content_type, "Edit")
  end

  def destroy?
    user_is_admin? || @user.has_permission?(@content_type, "Destroy")
  end

  private

  def user_is_admin?
    @user.has_role?(:admin)
  end
end
