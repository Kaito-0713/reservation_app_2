class AddUserToFacilities < ActiveRecord::Migration[6.1]
  def change
    add_reference :facilities, :user,foreign_key: true, null: true

    # 既存の施設にデフォルトで管理者ユーザー（id=1）を割り当てる場合
    # Facility.update_all(user_id: 1)

    # その後、NOT NULL 制約を追加
  end
end
