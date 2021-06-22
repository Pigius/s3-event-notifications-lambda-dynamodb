# frozen_string_literal: true

require 'date'
require 'securerandom'

require_relative '../adapters/dynamo_db_adapter'

class CreateMemeRecordService

  MemeRecordSchema = Struct.new(:id, :filename, :content_size, :created_at)

  def initialize(attributes)
    @attributes = attributes
  end

  def call
    meme = build_meme
    save(meme)
  end

  private

  attr_reader :attributes

  def save(coupon)
    DynamoDBAdapter.new.save_item(coupon)
  end

  def build_meme
    MemeRecordSchema.new(SecureRandom.uuid,
                         attributes[:filename],
                         attributes[:content_size],
                         DateTime.now.iso8601).to_h
  end
end
