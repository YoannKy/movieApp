class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
    	t.string :nom
    	t.text :description
    	t.binary :affiche
    	t.timestamps
    end
  end
end
