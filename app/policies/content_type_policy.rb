class ContentTypePolicy
  attr_reader :user, :content_type

  def initialize(user, content_type)
    @user = user
    @content_type = content_type
  end

  def index?
    user_is_admin?
  end

  def show?
    user_is_admin?
  end

  def create?
    user_is_admin?
  end

  def new?
    create?
  end

  def update?
    user_is_admin?
  end

  def edit?
    update?
  end

  def destroy?
    user_is_admin?
  end

  private

  def user_is_admin?
    @user.has_role?(:admin)
  end
end
