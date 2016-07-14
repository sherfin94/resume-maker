require_relative 'resume_maker_plugin'
require 'Prawn'

class PDFExporter < ResumeMakerPlugin
  @output_format = 'PDF'
  @file_extension = 'pdf'

  class << self
    attr_reader :output_format, :file_extension
  end

  def self.export(user, file_name)
    pdf = Prawn::Document.new
    user_details = user.to_hash
    user_details.each do |_key, value|
      pdf.text value, font_size: 72, justification: :center
    end

    pdf.render_file "#{file_name}.#{@file_extension}"
  end
end
