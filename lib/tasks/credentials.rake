# frozen_string_literal: true

namespace :credentials do
  desc 'Update credentials file'
  task :update, [:key, :value] do |_t, args|
    key_path = File.join(Rails.root, 'config', 'master.key').strip
    content_path = File.join(Rails.root, 'config', 'credentials.yml.enc')
    encrypted = Rails.application.encrypted(content_path, key_path: key_path)
    decrypted_content = encrypted.read
    hash = YAML.safe_load(decrypted_content)
    update_hash(hash, args[:key], args[:value])
    encrypted.write(hash.to_yaml)
  end

  def update_hash(yml, keys, value)
    *key, last = keys.split('-')
    if key.empty?
      yml[last] = value
    else
      yml[key.first] ||= {}
      key.inject(yml, :fetch)[last] = value
    end
  end
end
