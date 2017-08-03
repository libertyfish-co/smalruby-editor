#
Smalruby.UploadModalView = Backbone.View.extend
  events:
    'click #upload-modal-upload-button': 'onUpload'

  initialize: ->
    Smalruby.removeBackdropOnHidden(@$el)

  render: ->
    @$el.modal
      backdrop: 'static'
    @$el.modal('show')

  onUpload: (e) ->
    $.ajax
      url: '/source_codes/upload'
      type: 'POST'
      data:
        source_code:
          filename: "hogehoge"
      dataType: 'json'
      success: (data, textStatus, jqXHR) ->
        Smalruby.Views.MainMenuView.load(data.source_code)
