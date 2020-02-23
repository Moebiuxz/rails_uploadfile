# README

Primero agregar las siguientes gemas al Gemfile
- gem 'dropzonejs-rails'
- gem 'carrierwave'
- gem 'jquery-rails'

Realizar un 'bundle install'

Añadir al application.js

``//= require dropzone ``

Añadir al application.css

``*= require dropzone/dropzone``

Generar el media uploader

``rails g uploader media``

Crear el modelo

``rails g model media file_name:string``
```ruby
class Media < ActiveRecord::Base
    mount_uploader :file_name, MediaUploader
end
```


Crear el controlador

``rails g controller media_contents``

```ruby
class MediaContentsController < ApplicationController
  def create
    @media = Media.new(file_name: params[:file])
    if @media.save!
      respond_to do |format|
        format.json{ render :json => @media }
      end
    end
  end
end
```

Añadir la ruta

``resources :media_contents``

Agregar el formulario a la vista

```ruby
<%= form_tag '/media_contents', method: :post, class: "dropzone", id: "media-dropzone" do %>
  <input name="authenticity_token" type="hidden" value="<%= form_authenticity_token %>" />
  <div class="fallback">
    <%= file_field_tag "media", multiple: true%>
  </div>
<% end %>
```

Para capturar la respuesta con js

```javascript
<script>
    Dropzone.autoDiscover = false;
    $(function() {
        var mediaDropzone;
        mediaDropzone = new Dropzone("#media-dropzone");
        return mediaDropzone.on("success", function(file, responseText) {
            var imageUrl;
            imageUrl = responseText.file_name.url;
            console.log(responseText);
        });
    });
</script>
```