#
Smalruby.UploadModalView = Backbone.View.extend
  events:
    'click #upload-modal-send-button': 'onSend'

  initialize: ->
    Smalruby.removeBackdropOnHidden(@$el)

  render: ->
    @$el.modal
      backdrop: 'static'
    @$el.modal('show')

  onSend: (e) ->
    @$el.modal('hide')
