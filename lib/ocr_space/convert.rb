require 'ocr_space/file_post'
module OcrSpace
    module Convert
        def convert(apikey: @api_key, language: 'eng', isOverlayRequired: false, file: nil, url: nil, file_type: nil, OCREngine: 1, isTable: false,detectOrientation: false, isCreateSearchablePdf: false,isSearchablePdfHideTextLayer: false, scale: false)

          if file
            @files = File.new(file)
            @data = OcrSpace::FilePost.post('/parse/image',
                                            body: { apikey: apikey,
                                                    language: language,
                                                    isOverlayRequired: isOverlayRequired,
                                                    file_type: file_type,
                                                    OCREngine: OCREngine,
                                                    isTable: isTable,
                                                    detectOrientation: detectOrientation,
                                                    isCreateSearchablePdf: isCreateSearchablePdf,
                                                    isSearchablePdfHideTextLayer: isSearchablePdfHideTextLayer,
                                                    scale: scale,                                                    
                                                    file: @files })
            @data = @data.parsed_response['ParsedResults']
          elsif url
            @data = HTTParty.post('https://api.ocr.space/parse/image',
                                  body: { apikey: apikey,
                                          language: language,
                                          isOverlayRequired: isOverlayRequired,
                                          file_type: file_type,
					                      OCREngine: OCREngine,
					                      isTable: isTable,
					                      detectOrientation: detectOrientation,
					                      isCreateSearchablePdf: isCreateSearchablePdf,
					                      isSearchablePdfHideTextLayer: isSearchablePdfHideTextLayer,
					                      scale: scale,                                                    
                                          url: url })
            @data = @data.parsed_response['ParsedResults']
          else
            "You need to Pass either file or url."
          end
        end

        def clean_convert(apikey: @api_key, language: 'eng', isOverlayRequired: false, file: nil, url: nil)
          if file
            @files = File.new(file)
            @data = OcrSpace::FilePost.post('/parse/image',
                                            body: { apikey: apikey,
                                                    language: language,
                                                    isOverlayRequired: isOverlayRequired,
                                                    file_type: file_type,
	                                                OCREngine: OCREngine,
	                                                detectOrientation: detectOrientation,
	                                                scale: scale,                                                    
                                                    file: @files })
            @data = @data.parsed_response['ParsedResults'][0]["ParsedText"].gsub(/\r|\n/, "")
          elsif url
            @data = HTTParty.post('https://api.ocr.space/parse/image',
                                  body: { apikey: apikey,
                                          language: language,
                                          isOverlayRequired: isOverlayRequired,
                                          file_type: file_type,
	                                      OCREngine: OCREngine,
	                                      detectOrientation: detectOrientation,
	                                      scale: scale,                                                    
                                          url: url })
            @data = @data.parsed_response['ParsedResults'][0]["ParsedText"].gsub(/\r|\n/, "")
          else
            "You need to Pass either file or url."
          end
        end
    end
end
