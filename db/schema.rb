# frozen_string_literal: true

require_relative 'initializer'

ActiveRecord::Schema.define do
  create_table :ips, force: true, id: :string

  create_table :urls, force: true, id: :string do |t|
    t.bigint :visits_count
    t.bigint :ips_count
  end

  create_table :visits, force: true do |t|
    t.references :ip, type: :string
    t.references :url, type: :string
  end
end
