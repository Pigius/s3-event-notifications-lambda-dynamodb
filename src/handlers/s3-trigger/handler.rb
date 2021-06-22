# frozen_string_literal: true

require_relative '../../common/services/create_meme_record_service'

def run(event:, context:)
  CreateMemeRecordService.new(attributes(event)).call
end

def attributes(event)
  s3_object = event['Records'][0]['s3']['object']
  {
    filename: s3_object['key'],
    content_size: s3_object['size']
  }
end
