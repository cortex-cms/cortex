class ContentTypePolicy
  attr_reader :user, :content_type

  def initialize(user, content_type)
    @user = user
    @content_type = content_type
  end

  def index?
    @user.is_admin? || @user.is_superadmin?
  end

  def show?
    @user.is_admin? || @user.is_superadmin?
  end

  def create?
    @user.is_admin? || @user.is_superadmin?
  end

  def new?
    create?
  end

  def update?
    @user.is_admin? || @user.is_superadmin?
  end

  def edit?
    update?
  end

  def destroy?
    @user.is_admin? || @user.is_superadmin?
  end
end
