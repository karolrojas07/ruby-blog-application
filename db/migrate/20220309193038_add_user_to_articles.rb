# frozen_string_literal: true

# Documentation
class AddUserToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :user, null: false, foreign_key: true
  end
end
