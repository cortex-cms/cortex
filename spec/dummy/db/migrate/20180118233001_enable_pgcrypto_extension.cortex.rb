# This migration comes from cortex (originally 0)
class EnablePgcryptoExtension < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'
  end
end
