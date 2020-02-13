ActiveRecord::Schema.define(version: 20_200_213_002_737) do
  enable_extension 'plpgsql'

  create_table 'messages', force: :cascade do |t|
    t.string 'name',  null: false
    t.string 'email', null: false
    t.bigint 'phone'
    t.text   'body',  null: false

    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end
end
