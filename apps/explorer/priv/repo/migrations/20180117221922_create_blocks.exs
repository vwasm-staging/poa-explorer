defmodule Explorer.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks, primary_key: false) do
      add(:difficulty, :numeric, precision: 50)
      add(:gas_limit, :integer, null: false)
      add(:gas_used, :integer, null: false)
      add(:hash, :bytea, null: false, primary_key: true)
      add(:miner_hash, references(:addresses, column: :hash, type: :bytea), null: false)
      add(:nonce, :bytea, null: true)
      add(:number, :bigint, null: false)

      # not a foreign key to allow skipped blocks
      add(:parent_hash, :bytea, null: false)

      add(:size, :integer, null: false)
      add(:timestamp, :utc_datetime, null: false)
      add(:total_difficulty, :numeric, precision: 50)

      timestamps(null: false)
    end

    create(index(:blocks, [:timestamp]))
    create(unique_index(:blocks, [:parent_hash]))
    create(unique_index(:blocks, [:number]))
  end
end
