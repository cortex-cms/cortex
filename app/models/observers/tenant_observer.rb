class TenantObserver < ActiveRecord::Observer
  def before_save(tenant)
    init(tenant)
  end

  private

  def init(tenant)
    tenant.subdomain ||= tenant.name.mb_chars.normalize(:kd).downcase.gsub(/[^a-z0-9]/, '').to_s
  end
end
