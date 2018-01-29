class ImagesController < ApplicationController
  # https://github.com/ryanb/cancan/wiki/authorizing-controller-actions
  # authorize_resource
  # https://github.com/ryanb/cancan/issues/22
  authorize_resource class: false # removes the need for an empty model
  def serve_image

    # http://stackoverflow.com/questions/9462785/referencing-model-with-string-input
    # https://github.com/carrierwaveuploader/carrierwave/issues/614
    # model.avatar.file.filename
    # model[:avatar]
    # model.avatar_identifier
    # File.basename(model.file.path)


    if params[:id] && params[:model] && params[:type] && params[:id_image] && params[:uploader]

      model = params[:model].singularize.classify.constantize.find(params[:id_image])
      name =  model.read_attribute(params[:uploader].to_s)
      image_name = "#{params[:type]}_#{name}"

      image_path = File.join(Rails.root,"images",Rails.env, params[:model], params[:uploader], params[:id_image],image_name)

      unless send_file( image_path,disposition: 'inline', type: 'image/jpeg', x_sendfile: true )
        return "some default image" # ensure views have css defining  the size of thumbnail, that way default image is the proper size
      end
    end

  end
end
